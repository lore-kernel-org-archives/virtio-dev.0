Return-Path: virtio-comment-return-821-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 29 Jul 2019 10:54:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190729104802-mutt-send-email-mst@kernel.org>
References: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
 <1564386494-2296-2-git-send-email-yang.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564386494-2296-2-git-send-email-yang.huang@intel.com>
Subject: [virtio-comment] Re: [PATCH] Add virtio rpmb device specification
To: Huang Yang <yang.huang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, bing.zhu@intel.com, tomas.winkler@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 29, 2019 at 03:48:14PM +0800, Huang Yang wrote:
> It is a virtio based RPMB (Replay Protected Memory Block) device.
> 
> Signed-off-by: Yang Huang <yang.huang@intel.com>
> Reviewed-by: Bing Zhu <bing.zhu@intel.com>
> Reviewed-by: Tomas Winkler <tomas.winkler@intel.com> 
> 
> ---
>  conformance.tex | 18 +++++++++++-
>  content.tex     |  3 ++
>  virtio-rpmb.tex | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+), 1 deletion(-)
>  create mode 100644 virtio-rpmb.tex
> 
> diff --git a/conformance.tex b/conformance.tex
> index 0ac58aa..07166ba 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -22,7 +22,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>    \begin{itemize}
>      \item Clause \ref{sec:Conformance / Device Conformance}.
>      \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
> -    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance} or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
> +    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance}, \ref{sec:Conformance / Device Conformance / Socket Device Conformance} or \ref{sec:Conformance / Device Conformance / RPMB Device Conformance}.
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}
>  \end{description}
> @@ -183,6 +183,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / Socket Device / Device Operation / Device Events}
>  \end{itemize}
>  
> +\conformance{\subsection}{RPMB Driver Conformance}\label{sec:Conformance / Driver Conformance / RPMB Driver Conformance}
> +
> +A RPMB driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / RPMB Device / Device Operation}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>  
>  A device MUST conform to the following normative statements:
> @@ -338,6 +346,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / Socket Device / Device Operation / Receive and Transmit}
>  \end{itemize}
>  
> +\conformance{\subsection}{RPMB Device Conformance}\label{sec:Conformance / Device Conformance / RPMB Device Conformance}
> +
> +An RPMB device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / RPMB Device / Device Operation}
> +\end{itemize}
> +

Sorry this is not how we do it. Device and driver conformance are
separate sections, labeled appropriately. Device Operation should
include general prose that explains how they fit together.

>  \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
> diff --git a/content.tex b/content.tex
> index ee0d7c9..7f54f94 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2717,6 +2717,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  27         &   PMEM device \\
>  \hline
> +28         &   RPMB device \\
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
> index 0000000..b0b9ae1
> --- /dev/null
> +++ b/virtio-rpmb.tex
> @@ -0,0 +1,88 @@
> +\section{RPMB Device}\label{sec:Device Types / RPMB Device}
> +
> +virtio-rpmb is a virtio based RPMB (Replay Protected Memory Block)
> +device. It is used as a tamper-resistant and anti-replay storage.
> +It supports four command requests including read, write, get write
> +counter and program key. They are placed in the queue.
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
> +\subsection{Device Initialization}\label{sec:Device Types / RPMB Device / Device Initialization}

Below and everywhere, each conformance statement belongs to either
device or driver, listing either device or driver and
moved to the appropriate conformance section.

> +
> +\begin{enumerate}
> +\item The virtqueue is initialized.
> +\item The authentication key of device SHOULD NOT be programmed at the first initialization.

what does this imply exactly? what is "first initialization"? first
after which event? device reset?

> +\item The device size SHOULD be initialized to a multiple of 128 Kbytes and up to 16Mbytes.

what is device size and how does it affect operation?

> +\end{enumerate}
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

OK but what are these numbers in aid of? Does driver pass
these values to the device somehow?

> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
> +
> +The driver MUST configure and initialize all virtqueues for the requests received.
> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
> +
> +The device provides a simulated RPMB backed by ordinary file or
> +  other medium in host. It SHOULD keep consistent behaviors with
> +  hardware, including but not limited to:
> +\begin{enumerate}
> +\item The device maintains a monotonic write counter and an
> +   authentication key. Once the first successful key programming
> +   is performed, the authentication key MUST be kept unchanged
> +   during device lifecycle. The monotonic write counter MUST be
> +   added by one automatically after each successful write operation.
> +\item The RPMB device cannot be accessed until RPMB authentication

until after?

> +   key is programmed. 

and until device reset?

>For any operation (read, write, program key,
> +   get write counter) done to virtio RPMB device after authentication
> +   key is programmed successfully, the device responds with a MAC
> +   calculated by authentication key with HMAC-SHA to driver.

responds how?

> +\item The device MUST authenticate write operation by MAC calculated
> +   by authentication key and monotonic write counter .

authenticate how?

> +\end{enumerate}
> +
> +One of the below error codes MUST be returned to the driver
> +  based on the operation result.

how are they returned to driver?

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
> +\end{lstlisting}
> -- 
> 2.7.4

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

