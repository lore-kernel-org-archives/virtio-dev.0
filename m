Return-Path: virtio-return-3314-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 14 Mar 2019 16:26:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190314162440-mutt-send-email-mst@kernel.org>
References: <1552584494-10592-1-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552584494-10592-1-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH 1/1] conformance: clarify
 transitional/non-transitional
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 14, 2019 at 06:28:14PM +0100, Halil Pasic wrote:
> Clarify that legacy device descriptions are non-normative.  In fact
> virtio 0.9 is non-normative as a whole and always was by design: it was
> early days and spec evolved to document bugs in implementations.
> 
> Move the list of requirements associated with the legacy interface out
> of the Conformance chapter into its own chapter.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>

OK so we have two proposals on the table: this one and v5
that I sent.

If we can't resolve it I'll just do a ballot on both
and simple majority will decide.


> ---
> 
> Based on Michaels v3, and carries forward the idea of legacy interface
> not being a normative part of the virio specification.  This is something
> we should decide on.
> 
> This patch does not address all the issues raised by VIRTIO-167.
> 
> ---
>  cl-cs03.tex          |  4 +---
>  conformance.tex      | 61 ----------------------------------------------------
>  legacy-interface.tex | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  main.tex             |  2 ++
>  4 files changed, 57 insertions(+), 64 deletions(-)
>  create mode 100644 legacy-interface.tex
> 
> diff --git a/cl-cs03.tex b/cl-cs03.tex
> index 72925ca..5bfc42f 100644
> --- a/cl-cs03.tex
> +++ b/cl-cs03.tex
> @@ -225,9 +225,7 @@ Operation / Legacy Interface: Device Operation}, \ref{sec:Device
>  Types / Memory Balloon Device / Device Operation / Legacy
>  Interface: Device Operation}, \ref{sec:Device
>  Types / SCSI Host Device / Device Operation / Legacy
> -Interface: Device Operation} and \ref{sec:Conformance / Legacy
> -Interface: Transitional Device and Transitional Driver
> -Conformance}.
> +Interface: Device Operation} and \ref{sec:Legacy Interface Requirements}.
>  } \\
>  \hline
>  523 & 30 Apr 2015 & Michael S. Tsirkin & {VIRTIO-142:
> diff --git a/conformance.tex b/conformance.tex
> index ad7e82e..5365093 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -334,64 +334,3 @@ A socket device MUST conform to the following normative statements:
>  \item \ref{devicenormative:Device Types / Socket Device / Device Operation / Receive and Transmit}
>  \end{itemize}
>  
> -\section{Legacy Interface: Transitional Device and
> -Transitional Driver Conformance}\label{sec:Conformance / Legacy
> -Interface: Transitional Device and 
> -Transitional Driver Conformance}
> -A conformant implementation MUST be either transitional or
> -non-transitional, see \ref{intro:Legacy
> -Interface: Terminology}.
> -
> -A non-transitional implementation conforms to this specification
> -if it satisfies all of the MUST or REQUIRED level requirements
> -defined above.
> -
> -An implementation MAY choose to implement OPTIONAL support for the
> -legacy interface, including support for legacy drivers
> -or devices, by additionally conforming to all of the MUST or
> -REQUIRED level requirements for the legacy interface
> -for the transitional devices and drivers.
> -
> -The requirements for the legacy interface for transitional implementations
> -are located in sections named ``Legacy Interface'' listed below:
> -\begin{itemize}
> -\item Section \ref{sec:Basic Facilities of a Virtio Device /
> -Feature Bits / Legacy Interface: A Note on Feature Bits}
> -\item Section \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: A Note on Configuration Space endian-ness}
> -\item Section \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space}
> -\item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}
> -\item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Endianness}
> -\item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
> -\item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
> -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
> -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
> -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
> -\item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
> -\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
> -\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
> -\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Legacy Interfaces: A Note on Host->Guest Notification}
> -\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Legacy Interfaces: A Note on Setting Up Indicators}
> -\item Section \ref{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> -\item Section \ref{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
> -\item Section \ref{sec:Device Types / Network Device / Device Operation / Legacy Interface: Device Operation}
> -\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering / Legacy Interface: Setting MAC Address Filtering}
> -\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering / Legacy Interface: VLAN Filtering}
> -\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interface: Automatic receive steering in multiqueue mode}
> -\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State / Legacy Interface: Setting Offloads State}
> -\item Section \ref{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> -\item Section \ref{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
> -\item Section \ref{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
> -\item Section \ref{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
> -\item Section \ref{sec:Device Types / Console Device / Device configuration layout / Legacy Interface: Device configuration layout}
> -\item Section \ref{sec:Device Types / Console Device / Device Operation / Legacy Interface: Device Operation}
> -\item Section \ref{sec:Device Types / Memory Balloon Device / Feature bits / Legacy Interface: Feature bits}
> -\item Section \ref{sec:Device Types / Memory Balloon Device / Device Operation / Legacy Interface: Device Operation}
> -\item Section \ref{sec:Device Types / Memory Balloon Device / Device Operation / Memory Statistics / Legacy Interface: Memory Statistics}
> -\item Section \ref{sec:Device Types / SCSI Host Device / Device configuration layout / Legacy Interface: Device configuration layout}
> -\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Legacy Interface: Device Operation}
> -\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: Request Queues / Legacy Interface: Device Operation: Request Queues}
> -\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: controlq / Legacy Interface: Device Operation: controlq}
> -\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq / Legacy Interface: Device Operation: eventq}
> -\item Section \ref{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
> -\end{itemize}
> diff --git a/legacy-interface.tex b/legacy-interface.tex
> new file mode 100644
> index 0000000..f9e8f3a
> --- /dev/null
> +++ b/legacy-interface.tex
> @@ -0,0 +1,54 @@
> +\chapter{Legacy Interface Requirements \label{sec:Legacy Interface Requirements}}
> +
> +A transitional driver or device is a conforming driver or device (as
> +defined by section \ref{sec:Conformance / Conformance Targets}) that aims
> +for interoperability with the existing body of legacy devices or drivers
> +(see \ref{intro:Legacy Interface: Terminology}).
> +
> +No normative specification for the legacy interface exists, but to
> +facilitate inter-operability with non-conforming legacy implementations,
> +known differences between the legacy interface and the standard interface
> +are documented in non-normative sections named ``Legacy Interface''
> +listed below:
> +
> +\begin{itemize}
> +\item Section \ref{sec:Basic Facilities of a Virtio Device /
> +Feature Bits / Legacy Interface: A Note on Feature Bits}
> +\item Section \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: A Note on Configuration Space endian-ness}
> +\item Section \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space}
> +\item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}
> +\item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Endianness}
> +\item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
> +\item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
> +\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
> +\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
> +\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Legacy Interfaces: A Note on Host->Guest Notification}
> +\item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Legacy Interfaces: A Note on Setting Up Indicators}
> +\item Section \ref{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> +\item Section \ref{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
> +\item Section \ref{sec:Device Types / Network Device / Device Operation / Legacy Interface: Device Operation}
> +\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering / Legacy Interface: Setting MAC Address Filtering}
> +\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering / Legacy Interface: VLAN Filtering}
> +\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interface: Automatic receive steering in multiqueue mode}
> +\item Section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State / Legacy Interface: Setting Offloads State}
> +\item Section \ref{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> +\item Section \ref{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
> +\item Section \ref{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
> +\item Section \ref{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
> +\item Section \ref{sec:Device Types / Console Device / Device configuration layout / Legacy Interface: Device configuration layout}
> +\item Section \ref{sec:Device Types / Console Device / Device Operation / Legacy Interface: Device Operation}
> +\item Section \ref{sec:Device Types / Memory Balloon Device / Feature bits / Legacy Interface: Feature bits}
> +\item Section \ref{sec:Device Types / Memory Balloon Device / Device Operation / Legacy Interface: Device Operation}
> +\item Section \ref{sec:Device Types / Memory Balloon Device / Device Operation / Memory Statistics / Legacy Interface: Memory Statistics}
> +\item Section \ref{sec:Device Types / SCSI Host Device / Device configuration layout / Legacy Interface: Device configuration layout}
> +\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Legacy Interface: Device Operation}
> +\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: Request Queues / Legacy Interface: Device Operation: Request Queues}
> +\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: controlq / Legacy Interface: Device Operation: controlq}
> +\item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq / Legacy Interface: Device Operation: eventq}
> +\item Section \ref{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
> +\end{itemize}
> diff --git a/main.tex b/main.tex
> index b1913d6..f78f73b 100644
> --- a/main.tex
> +++ b/main.tex
> @@ -34,6 +34,8 @@
>  % Conformance
>  \input{conformance.tex}
>  
> +\input{legacy-interface.tex}
> +
>  % appendix
>  \appendix
>  \def\@chapapp{\appendixname}
> -- 
> 1.8.3.1
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

