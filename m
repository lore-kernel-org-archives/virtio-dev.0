Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20210813145351.GA5604@quicinc.com>
In-Reply-To: <20210813145351.GA5604@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Aug 2021 10:10:56 +0800
Message-ID: <CACGkMEuuS+u8M9ufN1g87ng1U5CT3gWEW899=o0NF0jWOA5aUg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 13, 2021 at 10:54 PM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> Reset of a virtio-mmio device is initiated by writing 0 to its Status
> register. The reset operation itself may or may not be completed by the t=
ime
> write instruction completes. For devices that are emulated in software, w=
rites
> to Status register are trapped and resumed only after the reset operation=
 is
> complete. Thus a driver can be assured of reset completion as soon as its=
 write
> completes. That may not be however true in other cases, such as when virt=
io-mmio
> devices implemented directly in hardware. Driver's write to Status regist=
er in
> such case could complete before the device reset operation is completed.
>
> Update the specification to indicate when a driver may need to poll for r=
eset
> completion before going ahead with the remaining initialization steps.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
>
> ---
> V2->V1:
> - Use version 0x3 as an indication for drivers to poll for reset completi=
on
>   (rather than base it on a new feature bit)
>
> Previous version can be found at:
>
> https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html
>
>  content.tex | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 7cec1c3..b6b30a0 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1730,9 +1730,9 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>    }
>    \hline
>    \mmioreg{Version}{Device version number}{0x004}{R}{%
> -    0x2.
> +    0x3.
>      \begin{note}
> -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}) used 0x1.
> +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}) used 0x1. Devices that do not require drivers=
 to poll for reset completion can use 0x2. See \ref{devicenormative:Virtio =
Transport Options / Virtio Over MMIO / MMIO Device Register Layout} for mor=
e details.
>      \end{note}
>    }
>    \hline
> @@ -1916,7 +1916,7 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>
>  The device MUST return 0x74726976 in \field{MagicValue}.
>
> -The device MUST return value 0x2 in \field{Version}.
> +The device MUST return either value 0x3 or 0x2 in \field{Version} based =
on its reset behavior. Drivers trigger reset of a device by writing 0 to \f=
ield{Status}. The reset operation itself may or may not be completed by the=
 time write operation is complete. Devices whose reset operation completes =
synchronously with the write operation are allowed to return value of 0x2 f=
or \field{Version}. Other devices, whose reset operation can be incomplete =
by the time write operation completes MUST return value 0x3 as an indicatio=
n for drivers to poll for reset completion.
>
>  The device MUST present each event by setting the corresponding bit in \=
field{InterruptStatus} from the
>  moment it takes place, until the driver acknowledges the interrupt
> @@ -1947,12 +1947,15 @@ \subsection{MMIO Device Register Layout}\label{se=
c:Virtio Transport Options / Vi
>  The driver MUST ignore a device with \field{MagicValue} which is not 0x7=
4726976,
>  although it MAY report an error.
>
> -The driver MUST ignore a device with \field{Version} which is not 0x2,
> +The driver MUST ignore a device with \field{Version} which is neither 0x=
2 nor 0x3,
>  although it MAY report an error.
>
>  The driver MUST ignore a device with \field{DeviceID} 0x0,
>  but MUST NOT report any error.
>
> +After writing 0 to \field{Status}, which triggers a reset of device, the=
 driver MUST wait for a read of
> +\field{Status} to return 0 before proceeding with the remaining steps of=
 initializing the device.
> +

Do we need to limit this behaviour to 0x3 only?

Thanks

>  Before reading from \field{DeviceFeatures}, the driver MUST write a valu=
e to \field{DeviceFeaturesSel}.
>
>  Before writing to the \field{DriverFeatures} register, the driver MUST w=
rite a value to the \field{DriverFeaturesSel} register.
>
>
> ---
>
> Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as=
 a
> non-member to the virtio-dev mailing list for consideration and inclusion=
.
>

