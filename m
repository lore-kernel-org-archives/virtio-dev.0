Return-Path: <virtio-dev-return-12361-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC32C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:36:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8B43D2A823
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:36:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 856489863AC
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:36:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7A9C498635B; Mon, 24 Apr 2023 15:36:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 643009866C2
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 15:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lXRUOJGHO8C0kY82iULyfw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682350585; x=1684942585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnAhXu5NVK+CUYiJoQcTfw6/CKRkPzwXqWlgf+CVS/g=;
        b=OPUqkTKy1n/Ulmq4Q+tcRW+lA5H4CsqIcYjKGWgkMf+252J/tVkOCFEFQG+qWwgHxs
         9shMZzjT+XcDH1s12pPhPq26dP4QXqQ7EdGxiuYl5KYIGTTyXdXxE/2S9FEHXFwk+aH9
         h0pxAfGCmUA5Bq9xxJ/qhdLyndwX4F8UC82aJ2AW+lFsFOXVGm0WZxZxalj71ypIMRnW
         GSO7UPn5SuTNUJ7hOQaIKsLlOCLLgLHVAC9V8L5aqGVMnzMokNpDNu/jehUGI/DLiLMp
         GlZHM6rtM5PScej1ked3bs6Vq42P+h6o9u6gjaKbz4W6rPpQSGADq6NJbaXleu9fz25J
         hixw==
X-Gm-Message-State: AAQBX9c/LT0uQeavCBiCY1tEZT1YDYFXJlCfNGEMGpwIeezoUL+5TBLv
	6+E7dCBb1s/R9o251sjnpHda9ZlPT2azyVPS2YOrp4dz1T/cMi/D3ebdKhkT799JD9HMK6cbMTh
	bcF4joVwTquS3MxKxgUUsXEoqJxeG
X-Received: by 2002:adf:e6d0:0:b0:2d1:7ade:aac with SMTP id y16-20020adfe6d0000000b002d17ade0aacmr10629214wrm.0.1682350585673;
        Mon, 24 Apr 2023 08:36:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZTl8tMA32IIVH1fTAzF7aWGZyJwT0gcir/fITbJ11QOPxNZR6KNn3QietdRbvF2Mdkle6nFA==
X-Received: by 2002:adf:e6d0:0:b0:2d1:7ade:aac with SMTP id y16-20020adfe6d0000000b002d17ade0aacmr10629197wrm.0.1682350585302;
        Mon, 24 Apr 2023 08:36:25 -0700 (PDT)
Date: Mon, 24 Apr 2023 11:36:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230424113515-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
 <a69f2e1d-bf93-8f65-791f-510d2703cd9a@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <a69f2e1d-bf93-8f65-791f-510d2703cd9a@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v11 05/10] pci: add admin vq
 registers to virtio over pci

On Thu, Apr 06, 2023 at 12:14:32AM -0400, Parav Pandit wrote:
> 
> 
> On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> > Add new registers to the PCI common configuration structure.
> > 
> > These registers will be used for querying the indices of the admin
> > virtqueues of the owner device. To configure, reset or enable the admin
> > virtqueues, the driver should follow existing queue configuration/setup
> > sequence.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > dropped Max's S.O.B
> > make queue_num not 0 based
> > ---
> >   content.tex | 34 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index 2eb15fa..5057df2 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -948,6 +948,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >           le64 queue_device;              /* read-write */
> >           le16 queue_notify_data;         /* read-only for driver */
> >           le16 queue_reset;               /* read-write */
> > +
> > +        /* About the administration virtqueue. */
> > +        le16 admin_queue_index;         /* read-only for driver */
> > +        le16 admin_queue_num;         /* read-only for driver */
> >   };
> >   \end{lstlisting}
> > @@ -1033,6 +1037,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >           This field exists only if VIRTIO_F_RING_RESET has been
> >           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > +\item[\field{admin_queue_index}]
> > +        The device uses this to report the index of the first administration virtqueue.
> > +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> > +\item[\field{admin_queue_num}]
> > +	The device uses this to report the number of the
> > +	supported administration virtqueues.
> > +	Virtqueues with index
> > +	between \field{admin_queue_index} and (\field{admin_queue_index} +
> > +	\field{admin_queue_num} - 1) inclusive serve as administration
> > +	virtqueues.
> > +	The value 0 indicates no supported administration virtqueues.
> no supported .. reads odd.
> How about,
> The value of 0 indicates that administration virtuques are unsupported.

I went back and forth on this but I feel "no queues" is clearer
in the end, and not odd: zero number of queues means no queues.

> > +	This field is valid only if VIRTIO_F_ADMIN_VQ has been
> > +	negotiated.
> >   \end{description}
> >   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> > @@ -1119,6 +1136,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >   were used before the queue reset.
> >   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> > +configures any administration virtqueues, the driver MUST
> > +configure the administration virtqueues using the index
> > +in the range \field{admin_queue_index} to
> > +\field{admin_queue_index} + \field{admin_queue_num} - 1 inclusive.
> > +The driver MAY configure less administration virtqueues than
> > +supported by the device.
> > +
> >   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > @@ -7686,6 +7711,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >     \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> >     administration virtqueues.
> > +  At the moment this feature is only supported for devices using
> > +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> > +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> > +	  as the transport and is reserved for future use for
> > +	  devices using other transports (see
> > +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
> > +	and
> > +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
> > +	handling features reserved for future use.
> >   \end{description}
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

