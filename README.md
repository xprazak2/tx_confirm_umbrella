# TxConfirm.Umbrella

```
ETHERSCAN_API_KEY="myApiKey" iex -S mix phx.server
```

* An umbrella is too much for a project of this size, but then all projects start small. Separating domain logic from web interface seems like a powerful idea.

* I use Etherscan API and fetch data from 2 endpoints. While I am not fond of multi-request workflows, doing 2 requests is still manageable and a much better solution compared to page scraping. HTML on the page is not a stable API and features which rely on it may be brittle.

* Etherscan API key is passed as env variable to fullfill the third commandment of 12 factor apps.

* I brought React from the start - SPAs seem usually faster because they do not do a full page refresh. React would also allow me to handle loading state more gracefuly compared to server side rendering if Etherscan API was slow, which does not seem to be the case. I did not bring any state management library as there is not much state to be managed. For any UI based on js framework, my preference would be to have it as a separate application which would make it much easier to put everything into containers.
