defmodule ReservemeWeb.Home.PageLive do
  use ReservemeWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col space-y-28 md:space-y-40">
      <article class="flex w-full justify-around h-1/3">
        <img class="w-2/4 md:w-2/3 h-72 md:h-2/3  md:max-h-[32rem]  rounded-lg object-cover" src={~p"/images/maison_exterieur.jpg"} />

        <div class="flex flex-col w-full px-2 w-2/4 md:w-1/3 justify-center max-w-[16rem]">
          <h1 class="text-md font-bold text-center mb-5">Maison en Vendée</h1>
          <p class="text-center">Pour profiter des beau jours, comme des temps pluvieux</p>
          <hr class="my-5" />

          <div class="text-center rounded-lg bg-secondary py-2 cursor-pointer w-full">
          <p>Je reserve</p>
          </div>
        </div>
      </article>

      <article class="flex flex-row-reverse w-full justify-around h-1/3">
        <img class="w-2/4 md:w-2/3  h-72 md:h-2/3 md:max-h-[32rem]  rounded-lg object-cover" src={~p"/images/plage_2.jpg"} />

        <div class="flex flex-col w-full px-2 w-2/4 md:w-1/3 justify-center max-w-[16rem]">
          <h1 class="text-md font-bold text-center mb-5">Profiter de la plage</h1>
          <p class="text-center">Aller se baigner, bronzer, profiter d’une glace ou faire un pique-nique</p>
          <hr class="my-5" />

          <div class="text-center rounded-lg bg-secondary py-2 cursor-pointer w-full">
          <p>Je reserve</p>
          </div>
        </div>
      </article>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end
