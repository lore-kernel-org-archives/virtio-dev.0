Return-Path: <virtio-dev-return-13264-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CE2EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:42:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3F8E894EE9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:42:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F000986808
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:42:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 085E8986728; Thu,  6 Jul 2023 16:42:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E96DF986729
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 16:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: MXf0kIauM_KFHyqbJeSQSg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688661731; x=1691253731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4oEQzVFHttrqFr784+tyPjp/YDKWlAD/WyPrc2CE2Y=;
        b=XeODsDrX35ML3pcBaF4xY643e9gFiakaDivNIxUslHDbKuXCGLQxL0+zgdnIbFkmKO
         m8vIL540pswZYBhfc4mrVC4Ktfsf2ufw+SipZVhpGf1HTCpVhyRbd1SmKB2nyq/v9Wxu
         gXNqPamqxpBZ6NrUf+qjmNrIhWIbwgXWoK+sWQ6+JtUiEDGbeRH7hPpPfx5FC3+vl26I
         N5V5y4RiKWlcpFPqfAymMLp7kEMdL/+e4+w+Xc6KPOZ4aVCRiYDaPCcGvMU3HFfP+E2G
         sAMoJZLgbr+U8dPz+UO3iF7FeBhf//yIBinr9DgdO9LTSwe8ZvnlEQvfww8nrO4YKOPz
         sY4w==
X-Gm-Message-State: ABy/qLY+ZusuMP1IUMFlyBfC84cKDgBxig343d1VsgeDmxaJIgc6GN7U
	L40JL6Nm5N3CT2wYzGCx5tj+jh5CDFHsH8Z+7+uTjC3Ad1EssIdQ6FkIMl9R7GzwLh73UvaGVaq
	f3/V+7k8Qr/BxBPsomts2pV0qsdukcN3iZdZX
X-Received: by 2002:a1c:7c19:0:b0:3f8:946:115d with SMTP id x25-20020a1c7c19000000b003f80946115dmr1821225wmc.30.1688661730816;
        Thu, 06 Jul 2023 09:42:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5echts1OPl073mOsaRFyAPC5bmG4Q4UFWYlOUP++rmp/lzaV8VXhiIJkKbDHcoNnTc+4wkw==
X-Received: by 2002:a1c:7c19:0:b0:3f8:946:115d with SMTP id x25-20020a1c7c19000000b003f80946115dmr1821203wmc.30.1688661730470;
        Thu, 06 Jul 2023 09:42:10 -0700 (PDT)
Date: Thu, 6 Jul 2023 12:42:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230706123954-mutt-send-email-mst@kernel.org>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
 <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06, 2023 at 04:33:01PM +0000, Parav Pandit wrote:
> 
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Thursday, July 6, 2023 12:28 PM
> > 
> > On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > diff --git a/transport-pci-legacy-regs.tex
> > > b/transport-pci-legacy-regs.tex new file mode 100644 index
> > > 0000000..ceea28c
> > > --- /dev/null
> > > +++ b/transport-pci-legacy-regs.tex
> > > @@ -0,0 +1,42 @@
> > > +\subsection{Legacy Interface: Group member device Configuration
> > > +Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI
> > > +Bus / Legacy Interface: Group Member Device Configuration Region
> > > +Access}
> > > +
> > > +The PCI owner device or the member device or both support driver
> > > +notifications using
> > 
> > What about
> > 
> > "The PCI owner device, the member device, or both can choose to support..." ?
> >
> Fine too.
> Any thing wrong in having or as above, so I don't write it next time?
> Or that in current form reads better to me.
>  
> > > +a notification region defined in \field{struct
> > virtio_pci_legacy_notify_region}.
> > > +
> > > +In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
> > > +\field{region_data} is defined as following:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_pci_legacy_notify_region {
> > > +        u8 owner;  /* When set to 1, notification region is of the owner device
> > */
> > > +        u8 bar;    /* BAR of the member or owner device */
> > > +        u8 padding[6];
> > > +        le64 offset; /* Offset within bar. */ }; \end{lstlisting}
> > > +
> > > +The group owner device hardwires VF BAR0 to zero in the SR-IOV
> > > +Extended capability.
> > > +
> > > +The group member device does not use PCI BAR0 in all the Virtio PCI
> > > +capabilities
> > 
> > "in [or for?] any of the...", I guess?
> Will change to "Any of the ".
> 
> > 
> > > +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus /
> > Virtio Structure PCI Capabilities}.
> > > +
> > > +\devicenormative{\subsubsection}{Legacy Interface: Group Member
> > > +Device Legacy Configuration Region Access}{Virtio Transport Options /
> > > +Virtio Over PCI Bus / Legacy Interface: Group Member Device
> > > +Configuration Region Access}
> > > +
> > > +When a PCI SR-IOV group owner device supports
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group
> > owner
> > > +device MUST hardwire VF BAR0 to zero in the SR-IOV Extended
> > > +capability and the group memberi
> > 
> > s/memberi/member/
> >
> Yes, already changed in my v11 where patch 3 and 4 content is merged to single generic section.
> 
>  
> > > +device MUST NOT use BAR0 in any of the Virtio Structure PCI Capabilities.
> > > +
> > > +The group owner device or the group member device or both MAY support
> > > +driver notifications region.
> > 
> > Make this "a driver notification region"?
> >
> Notifications are generally more than one and spec has the section "driver notifications", so...
>  

We will need to detail how notifications work though. The reason
is that the legacy notifications are received by owner driver
(which is not legacy!) and forwarded to device.
We need to explain exactly how this is done for people who
don't read minds and did not follow 3 months of mailing list
debates, and explain how this has the same effect as
triggering driver notification through the legacy
interface.





---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

