defmodule ReservemeWeb.Booking.BookingLive do
  use ReservemeWeb, :live_view
  use Timex

  import ReservemeWeb.LiveViewHelpers

  alias __MODULE__

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-center text-3xl mb-8 -mt-4">Réserver</h1>
      <div class="w-full divide-y lg:divide-x lg:divide-y-0 flex flex-col lg:flex-row">
      <BookingLive.calendar
        previous_month={7}
        next_month={9}
        current={@current}
        end_of_month={@end_of_month}
        beginning_of_month={@beginning_of_month}
        time_zone={@time_zone}
      />
      <div>

      </div>
      </div>
    </div>
    """
  end

  def calendar(
    %{
    previous_month: _previous_month,
    next_month: _next_month
    } = assigns
  ) do

    ~H"""
    <div class="w-full lg:w-1/2 rounded-2xl border border-primary p-3 shadow-lg mb-4 lg:mr-4">

      <div class="flex items-center mb-8">

        <div class="flex justify-center items-center space-x-6 flex-1 text-right">

            <button phx-click="previous-month" class="flex items-center justify-center w-10 h-10 rounded-full border-primary border align-middle rounded-full hover:scale-110 duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
            </svg>

            </button>

            <div class="capitalize">
              <%= Timex.lformat!(@current, "{Mshort} {YYYY}", "fr") %>
             </div>


            <button phx-click="next-month" class="flex items-center justify-center w-10 h-10 rounded-full border-primary border align-middle rounded-full hover:scale-110 duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
            </svg>

            </button>

        </div>
      </div>
      <div class="mb-6 text-center uppercase grid grid-cols-7 gap-x-2 gap-y-2 md:gap-y-4 md:gap-x-0">
        <div class="text-xs">Lun</div>
        <div class="text-xs">Mar</div>
        <div class="text-xs">Mer</div>
        <div class="text-xs">Jeu</div>
        <div class="text-xs">Ven</div>
        <div class="text-xs">Sam</div>
        <div class="text-xs">Dim</div>
        <%= for i <- 0..@end_of_month.day - 1 do %>
          <BookingLive.day
            index={i}
            date={Timex.shift(@beginning_of_month, days: i)}
            time_zone={@time_zone} />
        <% end %>
      </div>
    </div>
    """
  end

  def day(%{index: index, date: date, time_zone: time_zone} = assigns) do
    disabled = Timex.compare(date, Timex.today(time_zone)) == -1
    weekday = Timex.weekday(date, :monday)

    if index == 0 do
      IO.inspect(weekday)
    end

    class =
      class_list([
        {"col-start-#{weekday}", index == 0},
        {"content-center w-10 h-10 lg:w-12 lg:h-12 rounded-full justify-center items-center flex ", true},
        {"border-primary border font-bold hover:scale-110 duration-300 cursor-pointer shadow", not disabled},
        {"text-gray-200 cursor-default pointer-events-none", disabled}
      ])

    assigns =
      assigns
      |> assign(disabled: disabled)
      |> assign(:text, Timex.format!(date, "{D}"))
      |> assign(:class, class)

    ~H"""
    <div class="w-full flex justify-center">
    <div class={@class}>
      <p><%= @text %></p>
    </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:current, Timex.today())
      |> assign(:beginning_of_month, Timex.beginning_of_month(Timex.today()))
      |> assign(:end_of_month, Timex.end_of_month(Timex.today()))
      |> assign(:time_zone, Timex.local().time_zone)
    {:ok, socket}
  end

  def handle_event("next-month", _params, socket) do
    socket =
      socket
      |> update(:current, &Timex.shift(&1, months: 1))
      |> update(:beginning_of_month, &Timex.shift(&1, months: 1))
      |> update(:end_of_month, &Timex.shift(&1, months: 1))
    {:noreply, socket}
  end

  def handle_event("previous-month", _params, socket) do
    socket =
      socket
      |> update(:current, &Timex.shift(&1, months: -1))
      |> update(:beginning_of_month, &Timex.shift(&1, months: -1))
      |> update(:end_of_month, &Timex.shift(&1, months: -1))
    {:noreply, socket}
  end

end