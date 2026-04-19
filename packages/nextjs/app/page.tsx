import { ConnectWallet } from "~~/components/ConnectWallet";
import { DonorInfo } from "~~/components/DonorInfo";
import { TipForm } from "~~/components/TipForm";
import { TipJarStats } from "~~/components/TipJarStats";
import { WithdrawButton } from "~~/components/WithdrawButton";

export default function Home() {
  return (
    <main>
      <header>
        <h1>TipJar</h1>
        <ConnectWallet />
      </header>
      <TipJarStats />
      <TipForm />
      <DonorInfo />
      <WithdrawButton />
    </main>
  );
}
