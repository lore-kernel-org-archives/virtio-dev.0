Return-Path: <virtio-dev-return-8546-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDB929863E2
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Aug 2021 15:26:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210813145351.GA5604@quicinc.com>
References: <20210813145351.GA5604@quicinc.com>
Date: Tue, 17 Aug 2021 17:26:08 +0200
Message-ID: <87zgtgrt2n.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, tsoni@quicinc.com, pratikp@quicinc.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 13 2021, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> wrote:

> Reset of a virtio-mmio device is initiated by writing 0 to its Status
> register. The reset operation itself may or may not be completed by the time
> write instruction completes. For devices that are emulated in software, writes
> to Status register are trapped and resumed only after the reset operation is
> complete. Thus a driver can be assured of reset completion as soon as its write
> completes. That may not be however true in other cases, such as when virtio-mmio
> devices implemented directly in hardware. Driver's write to Status register in
> such case could complete before the device reset operation is completed.
>
> Update the specification to indicate when a driver may need to poll for reset
> completion before going ahead with the remaining initialization steps.
>     
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
>
> ---
> V2->V1:
> - Use version 0x3 as an indication for drivers to poll for reset completion
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
> @@ -1730,9 +1730,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>    } 
>    \hline
>    \mmioreg{Version}{Device version number}{0x004}{R}{%
> -    0x2.
> +    0x3.
>      \begin{note}
> -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1.
> +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1. Devices that do not require drivers to poll for reset completion can use 0x2. See \ref{devicenormative:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout} for more details.
>      \end{note}
>    }
>    \hline 
> @@ -1916,7 +1916,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  
>  The device MUST return 0x74726976 in \field{MagicValue}.
>  
> -The device MUST return value 0x2 in \field{Version}.
> +The device MUST return either value 0x3 or 0x2 in \field{Version} based on its reset behavior. Drivers trigger reset of a device by writing 0 to \field{Status}. The reset operation itself may or may not be completed by the time write operation is complete. Devices whose reset operation completes synchronously with the write operation are allowed to return value of 0x2 for \field{Version}. Other devices, whose reset operation can be incomplete by the time write operation completes MUST return value 0x3 as an indication for drivers to poll for reset completion.

Maybe I'm overthining this, but might that suddenly render some existing
device non-compliant? IIUC, we never mandated reset to be completed when
the write was completed, only kind of implied it. An existing device
will have version 2, but it might not be quite finished with reset after
the status write yet.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

