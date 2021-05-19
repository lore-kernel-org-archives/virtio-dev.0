Return-Path: virtio-dev-return-8171-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 032FF9861BA
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 May 2021 17:01:36 +0000 (UTC)
Date: Wed, 19 May 2021 19:01:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210519190125.3c421a9c.cohuck@redhat.com>
In-Reply-To: <CABATKF9BoZQJenux4ju8TpZAmgeoMNGLPj_Dq8YZf6YwGfD8wg@mail.gmail.com>
References: <CABATKF8SvvObHWu3OCuSG6goXHJL1R_XxxrnQ9p-9DsLEms6cg@mail.gmail.com>
	<20210517193617.1576401-1-chenhaosjtuacm@google.com>
	<CABATKF9BoZQJenux4ju8TpZAmgeoMNGLPj_Dq8YZf6YwGfD8wg@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3] Add virtio parameter server device specification
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 17 May 2021 12:37:30 -0700
Hao Chen <chenhaosjtuacm@google.com> wrote:

> This patch introduces a new type of device: parameter server. The device
> acts as a key-value store and the driver can read from, write to or
> subscribe to the properties in the server.
> 
> Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> ---
>  conformance.tex |  26 ++++++-
>  content.tex     |   1 +
>  virtio-ps.tex   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-ps.tex

Can you please provide some kind of change log?

> diff --git a/conformance.tex b/conformance.tex
> index a164cbb..0d6b1a5 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}

I'm afraid the line wrapping is still happening...

>  \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
> -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
> +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
> +\ref{sec:Conformance / Driver Conformance / Parameter Server Driver
> Conformance}.
> 
>      \item Clause \ref{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}

(...)

> diff --git a/virtio-ps.tex b/virtio-ps.tex
> new file mode 100644
> index 0000000..f84b211
> --- /dev/null
> +++ b/virtio-ps.tex
> @@ -0,0 +1,197 @@
> +\section{Parameter Server}\label{sec:Device Types / Parameter Server}
> +
> +The parameter server device manages a set of values with unique
> property IDs. These values may
> +either be static (i.e. have a constant value) or be dynamic (i.e.
> value may change over time).
> +The driver can get and set values, get value configurations,
> subscribe and unsubscribe dynamic
> +properties from the device. The driver will get updates when
> subscribed value changes. The device

'a subscribed value', or 'subscribed values', I guess.

You also need to explain what 'subscribed' means. Subscription to
change notifications/updates?

> +processes the requests from the driver, enforces the value access
> rules, and may potentially alter
> +the behavior of external systems as a result of driver operations.
> +
> +\subsection{Device ID}\label{sec:Device Types / Parameter Server / Device ID}
> +
> +38
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Parameter Server / Virtqueues}
> +
> +\begin{description}
> +\item[0] cmdq
> +\item[1] eventq
> +\end{description}
> +
> +\subsection{Feature Bits}\label{sec:Device Types / Parameter Server /
> Feature Bits}
> +
> +None currently defined.
> +
> +\subsection{Device Configuration Layout}\label{sec:Device Types /
> Parameter Server / Device Configuration Layout}
> +
> +\begin{lstlisting}
> +struct virtio_parameter_server_config {
> +    char name[128];
> +};
> +\end{lstlisting}
> +
> +A device configuration space only contains the name of the device,
> which can be used by the
> +userspace for identification.

What is 'userspace' in the context of this spec? I'd write

"\field{name} contains a name identifying the device."

Are there any further requirements (e.g. may the name be empty?)

<need to look at the remainder later>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

