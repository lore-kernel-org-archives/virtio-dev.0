Return-Path: virtio-return-3065-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 11 Apr 2018 09:50:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180411095018.61b0caed.cohuck@redhat.com>
In-Reply-To: <1523398287-25480-4-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
	<1523398287-25480-4-git-send-email-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [RFC PATCH 3/3] ccw: map common notifications terminology to
 ccw
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 11 Apr 2018 00:11:27 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

[Have not yet looked at your other patches, on my list.]

> The various notifications are introduced and specified in the common
> (i.e. transport agnostic) portion of this specification. How
> notifications are realised for a given transport is something each
> transport has to specify.
> 
> Let's make the relationship between the virtio-ccw terms and the common
> terms more obvious.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  content.tex |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 87cc0e2..27aa17b 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1938,6 +1938,17 @@ Bytes & Description & Contents \\
>  \hline
>  \end{tabular}
>  
> +A virtio-ccw proxy device facilitates:
> +\begin{itemize} 
> +\item Discovery and attachment of  virtio devices (as described above).
> +\item Initialization of vitqueues and transport specific facilities (using

s/vitqueues/virtqueues/

> +      custom channel commands).

s/custom/virtio-specific/ ?

In a sense, all channel commands other than the basic ones are
'custom' :) They are always device or control unit type specific, only
obeying some rules.

> +\item Notifications (via hypercall and virtual interrupts).

Why 'virtual' interrupts? Better call this 'I/O interrupts' (includes
both classic and adapter interrupts)?

> +\end{itemize} 
> +
> +\subsubsection{Channel Commands for Virtio}\label{sec:Virtio Transport Options / Virtio
> +over channel I/O / Basic Concepts/ Channel Commands for Virtio}
> +
>  In addition to the basic channel commands, virtio-ccw defines a
>  set of channel commands related to configuration and operation of
>  virtio:
> @@ -1958,6 +1969,36 @@ virtio:
>  #define CCW_CMD_READ_STATUS 0x72
>  \end{lstlisting}
>  
> +\subsubsection{Notifications}\label{sec:Virtio Transport Options / Virtio
> +over channel I/O / Basic Concepts/ Notifications}
> +
> +Available buffer notifications are realized as a hypercall. No additional
> +setup by the driver is needed. The operation of available buffer
> +notifications is described in section \ref{sec:Virtio Transport Options /
> +Virtio over channel I/O / Device Operation / Guest->Host Notification}.
> +
> +Used buffer notifications are realized either as so called classic or as
> +adapter interrupts depending on a transport level negotiation. The

"as so-called classic or adapter I/O interrupts"?

(I'd really like a reference to I/O interrupts here... especially as
the old, never standardized s390 transport used external interrupts.)

> +initialization is described in sections \ref{sec:Virtio Transport Options
> +/ Virtio over channel I/O / Device Initialization / Setting Up Indicators
> +/ Setting Up Classic Queue Indicators} and \ref{sec:Virtio Transport
> +Options / Virtio over channel I/O / Device Initialization / Setting Up
> +Indicators / Setting Up Two-Stage Queue Indicators} respectively.  The
> +operation of each flavor is described in sections \ref{sec:Virtio
> +Transport Options / Virtio over channel I/O / Device Operation /
> +Host->Guest Notification / Notification via Classic I/O Interrupts} and
> +\ref{sec:Virtio Transport Options / Virtio over channel I/O / Device
> +Operation / Host->Guest Notification / Notification via Adapter I/O
> +Interrupts} respectively. 
> +
> +Configuration change notifications are done using so called classic
> +interrupts. The initialization is described in section \ref{sec:Virtio

"so-called classic I/O interrupts"

> +Transport Options / Virtio over channel I/O / Device Initialization /
> +Setting Up Indicators / Setting Up Configuration Change Indicators} and
> +the operation in section \ref{sec:Virtio Transport Options / Virtio over
> +channel I/O / Device Operation / Host->Guest Notification / Notification
> +via Classic I/O Interrupts}.
> +
>  \devicenormative{\subsubsection}{Basic Concepts}{Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
>  
>  The virtio-ccw device acts like a normal channel device, as specified

In general, I like this.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

