Return-Path: <virtio-dev-return-12358-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585C8C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 14:00:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BBE3523D55
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 14:00:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1424986394
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 14:00:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A742D98634E; Mon, 24 Apr 2023 14:00:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9707C986350
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 14:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: z1KnYoRcMjCibLxawKABnA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344825; x=1684936825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyMhaKFOIwVQB0VAUlXe+BOmNlCxnKvUvDP657rsXDg=;
        b=Q5fY6GvC0PrbyXg7/EjmWIV2H7bFN3/UgcGxHh+nqJCU+H+bf9W/7xdmq4NTwYXqfI
         i8PlkF6Mru8N74q3u3/bGLSCPVA+DvQRKiQ3v4C6sbEu8wsTYMDUtBujJwBjIhXqGqLB
         ZyKnxQmhn69wodKGz3U7nOioufb2E/mODzqlc3r9CpDo0U71bHFAPZBSeKaO46s7LIir
         RzitM2Ocic5hMj+aLV530/e2gTBcWJRlPwsQwBahbtO9MzCyq9JzGMdazUwf950NpnEJ
         M7N03M/Pp/4cGDLQCYOb7N6ngtLuqQ+CDd9u8wzeLKohWdWnc1olh6xO2qL6dAvmAF7w
         40uQ==
X-Gm-Message-State: AAQBX9cn7CENulwt6gTYQzReDj/gFjUkKY8Y1JJxk2LoyySXIgASfp+L
	Jeuw20CALxzNhEGKsj9jNBvibT8Z8FtJ/es99UlakbpIr2ojOIFNSy4TgSQ9N0srBUCifGKmmYH
	OCof7+WvJkvbixFoOzqXOpca6mnim
X-Received: by 2002:a5d:4882:0:b0:2ef:b8d1:9560 with SMTP id g2-20020a5d4882000000b002efb8d19560mr10262098wrq.30.1682344825464;
        Mon, 24 Apr 2023 07:00:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350aebokPYKzisOzIFR969pZwxRHbzR4vJRmHVqCsGhI067u39yEMcdi4as/YhHxq7JT9u7tHzg==
X-Received: by 2002:a5d:4882:0:b0:2ef:b8d1:9560 with SMTP id g2-20020a5d4882000000b002efb8d19560mr10262079wrq.30.1682344825035;
        Mon, 24 Apr 2023 07:00:25 -0700 (PDT)
Date: Mon, 24 Apr 2023 10:00:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, sgarzare@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230424095923-mutt-send-email-mst@kernel.org>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-4-parav@nvidia.com>
 <20230422003757.0c1ce85b.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230422003757.0c1ce85b.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v14 03/11] content: Rename confusing queue_notify_data
 and vqn names

On Sat, Apr 22, 2023 at 12:37:57AM +0200, Halil Pasic wrote:
> On Wed, 19 Apr 2023 04:46:31 +0300
> Parav Pandit <parav@nvidia.com> wrote:
> 
> > Currently queue_notify_data register indicates the device
> > internal queue notification content. This register is
> > meaningful only when feature bit VIRTIO_F_NOTIF_CONFIG_DATA is
> > negotiated.
> > 
> > However, above register name often get confusing association with
> > very similar feature bit VIRTIO_F_NOTIFICATION_DATA.
> > 
> > When VIRTIO_F_NOTIFICATION_DATA feature bit is negotiated,
> > notification really involves sending additional queue progress
> > related information (not queue identifier or index).
> > 
> > Hence
> > 1. to avoid any misunderstanding and association of
> > queue_notify_data with similar name VIRTIO_F_NOTIFICATION_DATA,
> > 
> > and
> > 2. to reflect that queue_notify_data is the actual device
> > internal virtqueue identifier/index/data/cookie,
> > 
> > a. rename queue_notify_data to queue_notif_config_data.
> > 
> > b. rename ambiguous vqn to a union of vq_index and vq_config_data
> > 
> > c. The driver notification section assumes that queue notification contains
> > vq index always. CONFIG_DATA feature bit introduction missed to
> > update the driver notification section. Hence, correct it.
> [..]
> > diff --git a/content.tex b/content.tex
> > index e79d722..e1345ea 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -404,8 +404,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
> >  notification to the device.
> >  
> >  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > -this notification involves sending the
> > -virtqueue index to the device (method depending on the transport).
> > +this notification contains either virtqueue index if VIRTIO_F_NOTIF_CONFIG_DATA
> > +is not negotiated or device supplied virtqueue notification config data if
> > +VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
> 
> Here comes the cleanup I talked about in v3. 
> 
> > +
> > +A notification method and suppling such virtqueue notification config data is
> > +transport specific.
> >  
> >  However, some devices benefit from the ability to find out the
> >  amount of available data in the queue without accessing the virtqueue in memory:
> > @@ -416,7 +420,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
> >  the following information:
> >  
> >  \begin{description}
> > -\item [vqn] VQ number to be notified.
> > +\item [vq_index_config_data] Either virtqueue index or device supplied
> 
> Apparently this our name for either index or notification config data,
> but I don't think we ever use it.
> 
> 
> > +      queue notification config data corresponding to a virtqueue.
> >  \item [next_off] Offset
> >        within the ring where the next available ring entry
> >        will be written.
> > diff --git a/notifications-be.c b/notifications-be.c
> > --- a/notifications-be.c
> > +++ b/notifications-be.c
> > @@ -1,5 +1,5 @@
> >  be32 {
> > -	vqn : 16;
> > +	vq_index: 16; /* previously known as vqn */
> >  	next_off : 15;
> >  	next_wrap : 1;
> >  };
> > diff --git a/notifications-le.c b/notifications-le.c
> > index fe51267..8a19389 100644
> > --- a/notifications-le.c
> > +++ b/notifications-le.c
> 
> Should this file  be renamed to notifications-mmio-le.c? It is only
> used for mmio now.

I think it is good policy to name files after what they contain not after how they
are used.

> I guess, there is a two to think about it:
> * Notifications are mostly transport specific. In particular what
>   data structures are used for the virtqueue notifications and how
>   they are passed, that is entirely transport specific. So the 'layout'
>   and the normative statements describing the details should be in the
>   transport sections.
> * The facility bits and the capabilities are basically common. I.e. if
>   MMIO or/and Channel I/O were to ever support VIRTIO_F_NOTIF_CONFIG data
>   (by providing means for transporting the virtqueue notification config
>   data from the device to the driver), what you call the notification
>   value would be either virtqueue index or this notification config data.
> 
> You are taking the first approach here, and I'm fine with that. IMHO
> before we had the second approach implemented with vqn. I'm fine
> with taking the first approach as well, but your commit message says
> "rename ambiguous vqn to a union of vq_index and vq_config_data" which
> for me implies you actually intended to take the second approach.
> 
> > @@ -1,5 +1,5 @@
> >  le32 {
> > -	vqn : 16;
> > +	vq_index: 16; /* previously known as vqn */
> >  	next_off : 15;
> >  	next_wrap : 1;
> >  };
> > diff --git a/notifications-pci-le.c b/notifications-pci-le.c
> > new file mode 100644
> > index 0000000..ef60d15
> > --- /dev/null
> > +++ b/notifications-pci-le.c
> > @@ -0,0 +1,8 @@
> > +le32 {
> > +	union {
> > +		vq_index: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA not negotiated */
> > +		vq_notif_config_data: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA negotiated */ 
> > +	};
> > +	next_off : 15;
> > +	next_wrap : 1;
> > +};
> > diff --git a/transport-pci.tex b/transport-pci.tex
> > index 5d98467..04a9a80 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -319,7 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >          le64 queue_desc;                /* read-write */
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> > -        le16 queue_notify_data;         /* read-only for driver */
> > +        le16 queue_notif_config_data;   /* read-only for driver */
> >          le16 queue_reset;               /* read-write */
> >  };
> >  \end{lstlisting}
> > @@ -388,17 +388,21 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >  \item[\field{queue_device}]
> >          The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> >  
> > -\item[\field{queue_notify_data}]
> > +\item[\field{queue_notif_config_data}]
> >          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
> > -        The driver will use this value to put it in the 'virtqueue number' field
> > -        in the available buffer notification structure.
> > +        The driver will use this value when driver sends available buffer
> > +        notification to the device.
> >          See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
> >          \begin{note}
> >          This field provides the device with flexibility to determine how virtqueues
> >          will be referred to in available buffer notifications.
> > -        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
> > -        may benefit from providing another value, for example an internal virtqueue
> > -        identifier, or an internal offset related to the virtqueue number.
> > +        In a trivial case the device can set \field{queue_notif_config_data} to
> > +        virtqueue index. Some devices may benefit from providing another value,
> > +        for example an internal virtqueue identifier, or an internal offset
> > +        related to the virtqueue index.
> > +        \end{note}
> > +        \begin{note}
> > +        This field is previously known as queue_notify_data.
> >          \end{note}
> >  
> >  \item[\field{queue_reset}]
> > @@ -468,7 +472,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >  
> >  \drivernormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> >  
> > -The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation}, \field{queue_notify_off} or \field{queue_notify_data}.
> > +The driver MUST NOT write to \field{device_feature}, \field{num_queues},
> > +\field{config_generation}, \field{queue_notify_off} or
> > +\field{queue_notif_config_data}.
> >  
> >  If VIRTIO_F_RING_PACKED has been negotiated,
> >  the driver MUST NOT write the value 0 to \field{queue_size}.
> > @@ -1035,13 +1041,22 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
> >  
> >  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> >  the driver sends an available buffer notification to the device by writing
> > -the 16-bit virtqueue index
> > -of this virtqueue to the Queue Notify address.
> > +only the 16-bit notification value to the Queue Notify address of the
> 
> 
> You introduce the term notification value. Which basically means
> virtqueue index or virtqueue notification config data. Which is basically
> what is defined where you define vq_index_config_data (the latter is
> never ever used again).
> 
> > +virtqueue. A notification value depends on the negotiation of
> > +VIRTIO_F_NOTIF_CONFIG_DATA.
> >  
> > -When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > -the driver sends an available buffer notification to the device by writing
> > -the following 32-bit value to the Queue Notify address:
> > -\lstinputlisting{notifications-le.c}
> > +\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver sends an
> 
> 
> The leading \item is probably not intended. Breaks the build and makes
> no sense.
> 
> > +available buffer notification to the device by writing the following 32-bit
> > +value to the Queue Notify address:
> > +\lstinputlisting{notifications-pci-le.c}
> > +
> > +\begin{itemize}
> > +\item When VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated \field{vq_index} is set
> > +to the virtqueue index.
> > +
> > +\item When VIRTIO_F_NOTIFICATION_DATA is negotiated,
> > +\field{vq_notif_config_data} is set to \field{queue_notif_config_data}.
> > +\end{itemize}
> >  
> >  See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
> >  for the definition of the components.
> > @@ -1050,12 +1065,31 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
> >  for how to calculate the Queue Notify address.
> >  
> >  \drivernormative{\paragraph}{Available Buffer Notifications}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}
> > -If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
> > +
> > +If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver notification 
> > +MUST be a 16-bit notification.
> > +
> > +If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver notification 
> > +MUST be a 32-bit notification.
> > +
> > +If VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated:
> > +\begin{itemize}
> > +\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set the
> > +notification value to virtqueue index.
> > +
> > +\item If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver MUST set the
> > +\field{vq_index} to the virtqueue index.
> > +
> > +\end{itemize}
> > +
> > +If VIRTIO_F_NOTIF_CONFIG_DATA is negotiated:
> >  \begin{itemize}
> > -\item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
> > -\field{queue_notify_data} value instead of the virtqueue index.
> > -\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
> > -\field{vqn} field to the \field{queue_notify_data} value.
> > +\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set
> > +the notification value to \field{queue_notif_config_data}.
> > +
> > +\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set the
> > +\field{vq_notify_config_data} to the \field{queue_notif_config_data}
> > +value.
> >  \end{itemize}
> >  
> >  \subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

