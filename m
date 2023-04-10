Return-Path: <virtio-dev-return-12086-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0F2C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:23:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F1F4829FD5
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:23:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA1789863D8
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:23:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC01698632A; Mon, 10 Apr 2023 13:23:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9EC498631E
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 13:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: IdsHayxtPcCAuaeo-pA4sA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681132970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FHs05b8mKtgMV0ZlQi1Xu7fT2iRbGl0g/25OA1SBxs=;
        b=73uO6GeHiNcPGi/ImqINoJXMWtfRnOIzB/5U6niAFeYrrgJ72v+mJ2aXJXzzqzAJVl
         HoP0vuzqFleUeiXS5QPGAXSirXrDphQEjK3MH0ryX50kG8XXkdH2xr4KGNTm3T89Ry7Z
         SmiC43my/bwrdBbnj8ZlwZe67KwXjhzmMA83lRqOhkU9IyOL9Rl+EH3UhWglqlq9jrYC
         /e+2NCDBcgOFKfLgEWowKZyaBsPQzqfe091J5YNea/ynV71nG7Bjx6JlEk4G+lfj04yv
         Wxa8AXqJ9ME/JXttv03bdigHvQBPIsCih4I/s2v09DxyM6DOSiiU0vrVPS4M+BvYLU29
         9wtw==
X-Gm-Message-State: AAQBX9fQ+deWKPgVgJbp2IWzJQbjidosZUxp/bTqWf2MbHTNrL1HroSm
	/HkU4PD8Gi8TQqX1pWpyYQoWU6hPZ571yYXzcGEPw9hpd66ioQEr6/nODyTq7RNfpjRUPrSEeUc
	fSonaDNeBmBtylYzwVIbr6eEhf7SO
X-Received: by 2002:a5d:6d52:0:b0:2dc:c0da:409 with SMTP id k18-20020a5d6d52000000b002dcc0da0409mr6734056wri.27.1681132970727;
        Mon, 10 Apr 2023 06:22:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350be3DhnDYL4Fq1IRx8Eazh3xm1kpQS4Oh/emA6GK2rPD3Gx0n8M9zv4ubcRbC54VIPO3HAyoQ==
X-Received: by 2002:a5d:6d52:0:b0:2dc:c0da:409 with SMTP id k18-20020a5d6d52000000b002dcc0da0409mr6734037wri.27.1681132970425;
        Mon, 10 Apr 2023 06:22:50 -0700 (PDT)
Date: Mon, 10 Apr 2023 09:22:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230410092104-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
 <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11 04/10] admin: introduce virtio admin virtqueues

On Thu, Apr 06, 2023 at 12:08:03AM -0400, Parav Pandit wrote:
> 
> 
> On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> > The admin virtqueues will be the first interface used to issue admin commands.
> > 
> The admin virtqueue
> 
> > Currently the virtio specification defines control virtqueue to manipulate
> > features and configuration of the device it operates on:
> > virtio-net, virtio-scsi, etc all have existing control virtqueues. However,
> > control virtqueue commands are device type specific, which makes it very
> > difficult to extend for device agnostic commands.
> > 
> > Keeping the device-specific virtqueue separate from the admin virtqueue
> > is simpler and has fewer potential problems.
> 
> > I don't think creating
> > common infrastructure for device-specific control virtqueues across
> > device types worthwhile or within the scope of this patch series.
> >  > To support this requirement in a more generic way, this patch introduces
> > a new admin virtqueue interface.
> > The admin virtqueue can be seen as the virtqueue analog to a transport.
> > The admin queue thus does nothing device type-specific (net, scsi, etc)
> > and instead focuses on transporting the admin commands.
> > 
> > We also support more than one admin virtqueue, for QoS and
> > scalability requirements.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > explain ordering of commands as suggested by Stefan
> > dropped Max's S.O.B
> > reword commit log as suggested by David
> > minor wording fixes suggested by David
> > ---
> >   admin.tex   | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   content.tex |  7 +++--
> >   2 files changed, 80 insertions(+), 2 deletions(-)
> > 
> > diff --git a/admin.tex b/admin.tex
> > index c869a1a..f201bcd 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -182,3 +182,78 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >   \field{command_specific_data} and \field{command_specific_result}
> >   depends on these structures and is described separately or is
> >   implicit in the structure description.
> > +
> > +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> > +
> > +An administration virtqueue of an owner device is used to submit
> > +group administration commands. An owner device can have more
> > +than one administration virtqueue.
> > +
> > +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> > +or more adminstration virtqueues. The number and locations of the
> > +administration virtqueues are exposed by the owner device in a transport
> > +specific manner.
> > +
> > +The driver queues requests to an arbitrary administration
> The driver enqueues

Not sure why - these are synonims - and this variant is more popular:

[mst@tuck virtio]$ git grep 'The driver queues'
admin.tex:The driver queues requests to an arbitrary administration
content.tex:The driver queues requests to the virtqueues, and they are used by
content.tex:The driver queues requests to an arbitrary request queue, and
virtio-gpio.tex:\item The driver queues \field{struct virtio_gpio_request} and
virtio-i2c.tex:The driver queues requests to the virtqueue, and they are used by the
virtio-vsock.tex:The driver queues outgoing packets on the tx virtqueue and incoming packet
[mst@tuck virtio]$ git grep 'The driver enqueues'
virtio-fs.tex:The driver enqueues normal requests on an arbitrary request queue. High


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

