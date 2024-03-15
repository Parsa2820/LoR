import typer
from web3 import Web3


app = typer.Typer()


@app.callback()
def main(
    ctx: typer.Context,
    url: str = typer.Option(help="URL of the Ethereum node"),
    contract_address: str = typer.Option(help="Address of the contract"),
    private_key: str = typer.Option(help="Private key of the account"),
):
    ctx.obj = {
        "url": url,
        "contract_address": contract_address,
        "private_key": private_key,
    }


@app.command()
def ls(
    ctx: typer.Context
):
    """
    List all the coins (services)
    """
    pass


@app.command()
def status(
    ctx: typer.Context
):
    """
    Show the status of the trader
    """
    pass


@app.command()
def submit_coin(
    ctx: typer.Context,
    coin: str = typer.Argument(help="Name of the coin")
):
    """
    Submit a coin to the LoR instance
    """
    pass


if __name__ == "__main__":
    app()
    