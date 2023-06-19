Return-Path: <virtio-dev-return-12962-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290A0EB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:16:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 795C54282C
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:16:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55F2C986430
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:16:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 38C2B9863A6; Mon, 19 Jun 2023 16:16:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24D389863B0
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 16:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: w6z9vubEOm64mQDJC7eTZQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191396; x=1689783396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsh3/QaQfneJ75kam0RmHu0gwWrvaVohgZdu8sZYpn4=;
        b=KcTqaPoQ709dmFH4N4Up0PX6GAFKpN4HgT47v52FmoSx+z+CAqvquhK6UqBAmeup2K
         D3ljYlfU6s9g+32YLG6/eFOFt6QIa5fHYu4AjuG0KHqsJgKlAxljn1hNFy62QdrBh30t
         5qwBbheMafN17nuEkOr+L+GzYsJGbJtv+Es83KFIQw8p10W5UwGF5Rp+5SuNWFy3njbm
         luym81h6yiSRFwlb19vfplqPykQZdbYuH3YcPcnipLX0gyZpX19myqAFHu9toYWxVLVv
         KM3778cvy1/VqgEuQscLvADwE9cJoFKlcaHBqbBzMZCGN0BeVctAnemuN3uSLHysHdMB
         eZdQ==
X-Gm-Message-State: AC+VfDxyzGMN9zPMKdLtwvuNCOh7BBaa+nXCNPC5st2Qzg5NxmaeGZ1v
	+aet4OkQBEL/HBIuV94KoZgHka364U1SUz/aB698jnJxnYRxXY5XP5DbrR7nsiFGg7vVN5A7aD1
	EAqjPXmJfDEi9HWTFuNhixuRZwjsh
X-Received: by 2002:adf:cf02:0:b0:2ff:6906:7169 with SMTP id o2-20020adfcf02000000b002ff69067169mr9468961wrj.68.1687191396330;
        Mon, 19 Jun 2023 09:16:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JgM0wzcVZypjQKGwfsiLQ6h4VjYyQROI2u+qMmgcEq1V/KK8S6BtFBYQuh45r1lTaSdPSkg==
X-Received: by 2002:adf:cf02:0:b0:2ff:6906:7169 with SMTP id o2-20020adfcf02000000b002ff69067169mr9468949wrj.68.1687191395897;
        Mon, 19 Jun 2023 09:16:35 -0700 (PDT)
Date: Mon, 19 Jun 2023 12:16:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230619112050-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230613173015.1244486-5-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access

On Tue, Jun 13, 2023 at 08:30:15PM +0300, Parav Pandit wrote:
> This patch links how in a PCI transport a group owner can access group
> member (PCI VFs) legacy registers using a legacy registers access
> commands using administration virtqueue infrastructure.
> 
> Additionally it extend the PCI notification capability through which a
> PCI VF device indicates to the driver which PCI BAR region to be used
> for driver notifications.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> Signed-off-by: Parav Pandit <parav@nvidia.com>

I'd love to just put this stuff in a separate tex document
and just link there from the generic thing.
Or if it's too hard, please create new sections for
this stuff. But in this case each of these sections
has to start with repeating the description when
things apply. E.g. "when using legacy interface"
when using commands "A B C to access" etc etc.

I wrote a bunch of comments below.

> ---
> changelog:
> v5->v6:
> - aligned pci capability to 4B as required by PCI spec
> - added text for the PCI capability for the group member device
> v4->v5:
> - split pci transport and generic command section to new patch
> - removed multiple references to the VF
> - written the description of the command as generic with member
>   and group device terminology
> - reflected many section names to remove VF
> v3->v4:
> - moved noted to the conformance section details in next patch
> - removed queue notify address query AQ command on Michael's suggestion,
>   though it is fine. Instead replaced with extending virtio_pci_notify_cap
>   to indicate that legacy queue notifications can be done on the
>   notification location.
> - fixed spelling errors.
> - replaced administrative virtqueue to administration virtqueue
> - added queue notification capability register to indicate legacy q
>   notification supported
> v2->v3:
> - adddressed Jason and Michael's comment to split single register
>   access command to common config and device specific commands.
> - dropped the suggetion to introduce enable/disable command as
>   admin command cap bit already covers it.
> v1->v2:
> - addressed comments from Michael
> - added theory of operation
> - grammar corrections
> - removed group fields description from individual commands as
>   it is already present in generic section
> - added endianness normative for legacy device registers region
> - renamed the file to drop vf and add legacy prefix
> 
> - added overview in commit log
> - renamed subsection to reflect command
> ---
>  conformance.tex               |  3 +++
>  transport-pci-legacy-regs.tex | 48 +++++++++++++++++++++++++++++++++++
>  transport-pci.tex             | 20 +++++++++++++++
>  3 files changed, 71 insertions(+)
>  create mode 100644 transport-pci-legacy-regs.tex
> 
> diff --git a/conformance.tex b/conformance.tex
> index 6bac4b0..93f409c 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -267,6 +267,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
> +\item Section \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
> +\item Section \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
> +\item Section \ref{par:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: Notification capability}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
>  \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
>  \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
> diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
> new file mode 100644
> index 0000000..b671b3e
> --- /dev/null
> +++ b/transport-pci-legacy-regs.tex
> @@ -0,0 +1,48 @@
> +\subsection{Legacy Interfaces: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: Group Member Device Configuration Region Access}
> +
> +As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]} PCI VFs
> +do not support the I/O space BAR. Due to this limitation, a PCI VF hardware
> +device that supports legacy interfaces cannot be attached as passthrough
> +device to the guest virtual machine.

That's not the only reason. Let's keep things generic and start by
saying something like "Some configurations with a need to
support legacy drivers can not implement a transitional
device. For example .... ".

> +
> +To have a transitional or legacy virtio device in the guest virtual machine,
> +a PCI PF device as a group owner may

may -> can outside conformance statements.

> support accessing its group member

Pls keep it generic. A group owner ....


> +device's legacy configuration region using the group administration commands
> +listed at \ref{sec:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interfaces: legacy configuration access commands}.
> +These legacy configuration access commands are transported via the
> +administration virtqueue.

are these called legacy configuration access commands then?
why do you introduce this term? it does not look like it's used
anywhere else.


I would prefer it if you just use the term "legacy interface"
it is well defined and widely used in the spec.

again leave virtqueue out of it pls we'll have other ways
down the road. what matters is that they are transferred
to a group member by sending legacy configuration access commands
to the group owner.


> This mechanism enables minimal involvement of the
> +hypervisor software only for the purpose of the legacy configuration region access.

Leave marketing out of it pls, kill last sentence.



> +
> +When a guest virtual machine requests legacy configuration and device
> +specific regions

wait so now it's legacy configuration and device specific
regions and these two are distinct?

> of group member device, a hypervisor software accesses
> +it using an administration virtqueue

please talk of administration commands. virtqueue does not matter
at all.

> on behalf of the guest virtual machine.



To put it in our terms, something like this:
	when a legacy driver accesses a member device of
	a group using the
	legacy interface, a modern driver can intercept
	the access and forward it to the owner device.



> +
> +Even though virtqueue driver notifications can be communicated through
> +administration virtqueue, if the group member device support such

supports?

> +notifications using a memory-mapped operation, such driver notifications
> +are sent using a group member device defined notification region.

what does "are sent" imply here? is there a matching conformance
statement? who sends them?

> +
> +The group owner device

this is the 1st you mention any group or its owner.

> should not expose PCI BAR0

Not PCI BAR0. That is in header. You mean VF BAR0.

> for the group member
> +devices when it prefers to support legacy interface for legacy configuration
> +access using its group owner.

don't use should outside conformance


I think this specific case actually should be more specific.
Something like:

- For PCI SRIOV groups, when group owner device implements commands
  A,B,C the group owner's VF BAR 0 is hardwired to 0
  in its PCI SRIOV capability.


> +This facilitates hypervisor software to operate with least amount of
> +complexities

complexity is its own plural

> to emulate the legacy interface I/O space BAR and passthrough
> +other PCI BARs and PCI device capabilities to the guest virtual machine
> +without any translation.
> +
> +The group member device should not expose PCI BAR0 in various PCI capabilities.
> +
> +\devicenormative{\subsubsection}{Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
> +
> +When a PCI SR-IOV group owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group owner device SHOULD
> +NOT expose PCI BAR0 in the SR-IOV Extended capability. This is to facilitate the
> +software to emulate I/O region BAR0 for supporting the legacy interface.

not PCI BAR0 - VF BAR0. Check the PCI spec 
you can not "not expose it". if you want to
register can be "unimplemented".
Base Address registers are hardwired to zero

But it is better to be specific on what should happen. hardwire VF BAR0 to 0, right?


> +
> +\drivernormative{\subsubsection}{Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
> +
> +The driver SHOULD NOT emulate I/O region BAR0 if a device group member exposes
> +a PCI BAR0.

what does "emulate" mean here? which driver it is?

> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..3647485 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -541,6 +541,8 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
>  struct virtio_pci_notify_cap {
>          struct virtio_pci_cap cap;
>          le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
> +        u8 legacy_q_notify_supported;

I am still mulling whether VIRTIO_PCI_CAP_NOTIFY_CFG would be better.


> +	u8 reserved[3];


align with spaces pls.


>  };
>  \end{lstlisting}
>  
> @@ -560,6 +562,14 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
>  the same Queue Notify address for all queues.
>  \end{note}
>  
> +\field{legacy_q_notify_supported} when set to 1,


Do you mean something like: 
When \field{legacy_q_notify_supported} this indicates that ...

> indicates that the device
> +supports legacy queue notifications at this notification location.

And what location? this refers to what? the location described by
this capability maybe?


More specifically, assume a transitional device (with an IO BAR
as normal). Does presence of this flag in the capability
imply we can use a legacy queue but use this
notification with this capability?
I worry that if we allow that, it opens floodgates of people
who are too lazy to upgrade to 1.0 but just hack
this notification in there.





> Legacy Queue
> +Notification address is derived within a BAR for a virtqueue:
> +
> +\begin{lstlisting}
> +        cap.offset
> +\end{lstlisting}
> +
>  \devicenormative{\paragraph}{Notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>  The device MUST present at least one notification capability.
> 

I don't get what this is saying.  I *think* you really mean is
that queue_notify_off is 0.

 
> @@ -596,6 +606,14 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
>  cap.length >= queue_notify_off * notify_off_multiplier + 4
>  \end{lstlisting}
>  
> +\paragraph{Legacy Interfaces: Notification capability}\label{par:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: Notification capability}
> +
> +The device SHOULD set \field{legacy_q_notify_supported}

why SHOULD and not MUST here - if driver checks for it then it won't work without no?

> when the device
> +notification location supports legacy driver notifications.

legacy driver notifications is ambigous.
what you want here and elsewhere is something like
"when used through a legacy interface, device supports driver

> +
> +The driver in the hypervisor MAY use notification location for accessing
> +legacy queue notify address when the device supports it.
> +
>  \subsubsection{ISR status capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
>  
>  The VIRTIO_PCI_CAP_ISR_CFG capability
> @@ -1212,3 +1230,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>          re-examine the configuration space to see what changed.
>      \end{itemize}
>  \end{itemize}
> +
> +\input{transport-pci-legacy-regs.tex}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

