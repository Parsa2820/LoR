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
def run(ctx: typer.Context):
    """
    Run the trader daemon
    """
    while True:
        print("Running the trader daemon")


if __name__ == "__main__":
    app()
    