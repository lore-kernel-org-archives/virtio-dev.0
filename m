Return-Path: virtio-dev-return-5904-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4772D985BC1
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 12:16:34 +0000 (UTC)
Date: Wed, 31 Jul 2019 14:16:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190731141629.2cfd5bc7.cohuck@redhat.com>
In-Reply-To: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
References: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v2] Add virtio rpmb device specification
To: Huang Yang <yang.huang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 30 Jul 2019 21:46:14 +0800
Huang Yang <yang.huang@intel.com> wrote:

> It is a virtio based RPMB (Replay Protected Memory Block) device.
> 
> Signed-off-by: Yang Huang <yang.huang@intel.com>
> Reviewed-by: Bing Zhu <bing.zhu@intel.com>
> Reviewed-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> v1 -> v2:
> 1. update conformance.
> 2. wordings change:
>    first initialization -> first device initialization
>    device size -> device capacity
> 3. update Device Operation:
>    add more decriptions on write counter, key and write operations.
> ---
>  conformance.tex |  19 ++++++++++-
>  content.tex     |   3 ++
>  virtio-rpmb.tex | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 virtio-rpmb.tex
> 

(...)

> diff --git a/content.tex b/content.tex
> index ee0d7c9..7f54f94 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2717,6 +2717,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  27         &   PMEM device \\
>  \hline
> +28         &   RPMB device \\

Depending on how long it will take to get this into shape, it might be
a good idea to reserve the id separately.

> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> @@ -5677,6 +5679,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  \input{virtio-input.tex}
>  \input{virtio-crypto.tex}
>  \input{virtio-vsock.tex}
> +\input{virtio-rpmb.tex}
>  
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  
> diff --git a/virtio-rpmb.tex b/virtio-rpmb.tex
> new file mode 100644
> index 0000000..aa113bb
> --- /dev/null
> +++ b/virtio-rpmb.tex
> @@ -0,0 +1,100 @@
> +\section{RPMB Device}\label{sec:Device Types / RPMB Device}
> +
> +virtio-rpmb is a virtio based RPMB (Replay Protected Memory Block)
> +device. It is used as a tamper-resistant and anti-replay storage.
> +It supports four command requests including read, write, get write
> +counter and program key. They are placed in the queue.

What about replacing the last two sentences with:

"The device is driven via requests including read, write, get write
counter, and program key, which are submitted via a request queue." ?

> +
> +\subsection{Device ID}\label{sec:Device Types / RPMB Device / Device ID}
> +
> +28
> +
> +\subsection{Virtqueues}\label{sec:Device Types / RPMB Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / RPMB Device / Feature bits}
> +
> +None.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / RPMB Device / Device configuration layout}
> +
> +None.
> +
> +\devicenormative{\subsection}{Device Initialization}{Device Types / RPMB Device / Device Initialization}
> +
> +\begin{enumerate}
> +\item The virtqueue is initialized.
> +\item The authentication key of device SHOULD NOT be programmed at the first device initialization.
> +\item The device capacity SHOULD be initialized to a multiple of 128 Kbytes and up to 16Mbytes.
> +\end{enumerate}

I would place a slightly more verbose description of how the device
should be initialized into a descriptive section and only leave the
normative statements here.

Also, why SHOULD/SHOULD NOT instead of MUST/MUST NOT? Especially the
device capacity requirements feel like something that should not be too
loosely defined.

Would it make sense to expose the capacity through the config space?


> +
> +\subsection{Device Operation}\label{sec:Device Types / RPMB Device / Device Operation}
> +
> +The operation of a virtio RPMB device is driven by the requests placed on the virtqueue.
> +  The type of the request can be program key (VIRTIO_RPMB_REQ_PROGRAM_KEY),
> +  get write counter (VIRTIO_RPMB_REQ_GET_WRITE_COUNTER),
> +  write (VIRTIO_RPMB_REQ_DATA_WRITE), and read (VIRTIO_RPMB_REQ_DATA_READ).
> +  A program key or write request can also combine with a
> +  result read (VIRTIO_RPMB_REQ_RESULT_READ) for a returned result.
> +
> +\begin{lstlisting}
> +#define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
> +#define VIRTIO_RPMB_REQ_GET_WRITE_COUNTER  0x0002
> +#define VIRTIO_RPMB_REQ_DATA_WRITE         0x0003
> +#define VIRTIO_RPMB_REQ_DATA_READ          0x0004
> +#define VIRTIO_RPMB_REQ_RESULT_READ        0x0005
> +\end{lstlisting}

What form do the requests that are placed on the queue take?

> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
> +
> +The driver MUST configure and initialize all virtqueues for the requests received.

But there is only a single virtqueue, isn't there? This requirement
looks a bit odd.

> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
> +
> +The device provides a simulated RPMB backed by ordinary file or
> +  other medium in host. It SHOULD keep consistent behaviors with
> +  hardware, including but not limited to:

If this device is supposed to simulate the behaviour of a real device,
the virtio spec needs to point to a specification of that behaviour as
a normative reference. From the information contained here, I would
have no clue how to actually produce a conforming device or driver
implementation.

> +\begin{enumerate}
> +\item The device maintains an authentication key. Once the first
> +   successful key programming is performed, the authentication
> +   key MUST be kept unchanged during device lifecycle. It cannot
> +   be overwritten, erased or read. This key MUST be kept regardless
> +   of device reset or reboot.
> +\item The device maintains a monotonic write counter. It MUST be
> +   initialized to zero and added by one automatically after each
> +   successful write operation. The value cannot be reset. After
> +   the counter has reached its maximum value 0xFFFFFFFF, it will
> +   not be incremented anymore. This counter MUST be kept regardless
> +   of device reset or reboot.
> +\item The RPMB device cannot be successfully accessed until RPMB
> +   authentication key is programmed. For any operation (read, write,
> +   program key, get write counter) done to virtio RPMB device after
> +   authentication key is programmed successfully, the device responds
> +   with a MAC calculated by HMAC-SHA with authentication key to driver.
> +\item For write operation, the device MUST compare the writer counter
> +   it receives with the one it maintained internally. If the two are
> +   not equal, a VIRTIO_RPMB_RES_COUNT_FAILURE SHOULD be returned as
> +   the result. The device MUST calculate the MAC using HMAC-SHA. The
> +   authentication key acts as an input of the calculation. If the MAC
> +   are not equal to the one it received, a VIRTIO_RPMB_RES_AUTH_FAILURE
> +   SHOULD be returned as the result.
> +\item
> +\end{enumerate}

I think the spec would again benefit from putting the verbose
description of what the driver needs to do to access the device and how
the device needs to react into a descriptive section, and only keep
some simple normative statements here.

> +
> +One of the below error codes MUST be returned to the driver
> +  based on the operation result.
> +
> +\begin{lstlisting}
> +#define VIRTIO_RPMB_RES_OK                     0x0000
> +#define VIRTIO_RPMB_RES_GENERAL_FAILURE        0x0001
> +#define VIRTIO_RPMB_RES_AUTH_FAILURE           0x0002
> +#define VIRTIO_RPMB_RES_COUNT_FAILURE          0x0003
> +#define VIRTIO_RPMB_RES_ADDR_FAILURE           0x0004
> +#define VIRTIO_RPMB_RES_WRITE_FAILURE          0x0005
> +#define VIRTIO_RPMB_RES_READ_FAILURE           0x0006
> +#define VIRTIO_RPMB_RES_NO_AUTH_KEY            0x0007
> +#define VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED  0x0080

These return codes probably need some more description. Also, how are
they returned?

> +\end{lstlisting}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

