Return-Path: <virtio-dev-return-11422-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40128C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:37:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8013C2AC60
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:37:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74EF39867AC
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:37:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6911E9867A1; Fri,  3 Mar 2023 13:37:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58A039867A3
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 13:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Z-rqL3z6OhGRbDv-zapdcQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL9dIB/gsontD6h1QVe0P/0nUs0X8xufj9Z6cax67ig=;
        b=EG+viXAbjqY1c+cXXfGWIc7YnnDYiAxUuUjXAdccZGxjeDiykHGlZxKTjLn0zAfI9y
         FUejGe0P156Pe1YsAVSIVByf6iDnXpRxTF8f4de6Dy72bWfQEj4NDnjGH/1OSIQOW2J/
         KA5DsziS2vfQpEZu+nyaXfsynWTQrX9sZN+MeVl1pyP4UFVawTi9zGnVPt4dNH9rQWrQ
         sEFxXbrR/r1TBamiSwCMXd0CcTJTutMxP7+bt5qOVukHgBTIpAVG8/RmrWGSlhN569kR
         6AxFTEP88yUyADtViIKoHpVq1nXKp0dXiunZ9kCxZuxXsc9HcugnD2DHlUCOnN5tA7Bl
         F2VA==
X-Gm-Message-State: AO0yUKUIGVR84f9UxFHiNjI5ASTucHiIlSmYTuIO7uWZ3VtGDuz+Qr43
	kI7iycZAlYYBAC8a8xUXcXU0NaeWd2UNqy7VTyBdcQjF8/9pxB/+0ftXIPgk2LCA3iUe/6rNxhF
	e6GeXhqJRw4GS6X6fEGb2WOAS95uW
X-Received: by 2002:a05:600c:46c6:b0:3eb:3cc9:9f85 with SMTP id q6-20020a05600c46c600b003eb3cc99f85mr1807196wmo.26.1677850655465;
        Fri, 03 Mar 2023 05:37:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+kEGATXEUz0uZe6OTuCQPi/14kOFv1PTZoGtbtz6n3UFjdjR1nTgr0hRgdzmknW4mZYJ5KuQ==
X-Received: by 2002:a05:600c:46c6:b0:3eb:3cc9:9f85 with SMTP id q6-20020a05600c46c600b003eb3cc99f85mr1807173wmo.26.1677850655143;
        Fri, 03 Mar 2023 05:37:35 -0800 (PST)
Date: Fri, 3 Mar 2023 08:37:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230303083213-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
MIME-Version: 1.0
In-Reply-To: <20230303132840.GC2866370@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 04/10] admin: introduce virtio admin virtqueues

On Fri, Mar 03, 2023 at 08:28:40AM -0500, Stefan Hajnoczi wrote:
> On Thu, Mar 02, 2023 at 07:05:14PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 02, 2023 at 03:40:07PM -0500, Stefan Hajnoczi wrote:
> > > On Thu, Mar 02, 2023 at 08:05:06AM -0500, Michael S. Tsirkin wrote:
> > > > The admin virtqueues will be the first interface to issue admin commands.
> > > > 
> > > > Currently virtio specification defines control virtqueue to manipulate
> > > > features and configuration of the device it operates on. However,
> > > > control virtqueue commands are device type specific, which makes it very
> > > > difficult to extend for device agnostic commands.
> > > > 
> > > > To support this requirement in a more generic way, this patch introduces
> > > > a new admin virtqueue interface.
> > > 
> > > Is this referring to the existing virtio-net, virtio-scsi, etc control
> > > virtqueues?
> > > 
> > > I see the admin virtqueue as the virtqueue equivalent to transport
> > > feature bits. The admin queue does nothing device type-specific (net,
> > > scsi, etc) and instead focusses on transport and core virtio tasks.
> > > 
> > > Keeping the device-specific virtqueue separate from the admin virtqueue
> > > is simpler and has fewer potential problems. I don't think creating
> > > common infrastructure for device-specific control virtqueues across
> > > device types worthwhile or within the scope of this patch series.
> > 
> > yes this commit log is outdated. referred to original
> > proposal by Max which also planned to replace cvq.
> > will update.
> > 
> > 
> > > > We also support more than one admin virtqueue, for QoS and
> > > > scalability requirements.
> > > > 
> > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  content.tex |  7 +++--
> > > >  2 files changed, 79 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/admin.tex b/admin.tex
> > > > index 7e28b77..3ffac2e 100644
> > > > --- a/admin.tex
> > > > +++ b/admin.tex
> > > > @@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> > > >  \field{command_specific_data} and \field{command_specific_result}
> > > >  depends on these structures and is described separately or is
> > > >  implicit in the structure description.
> > > > +
> > > > +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> > > > +
> > > > +An administration virtqueue of an owner device is used to submit
> > > > +group administration commands. An owner device can have more
> > > > +than one administration virtqueue.
> > > > +
> > > > +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> > > > +or more adminstration virtqueues. The number and locations of the
> > > > +administration virtqueues are exposed by the owner device in a transport
> > > > +specific manner.
> > > > +
> > > > +The driver submits commands by queueing them to an arbitrary
> > > > +administration virtqueue, and they are processed by the
> > > > +device in the order in which they are queued. It is the
> > > > +responsibility of the driver to ensure ordering for commands
> > > > +placed on different administration virtqueues, because they will
> > > > +be executed with no order constraints.
> > > 
> > > Does "they are processed by the device in the order in which they are
> > > queued" mean only 1 admin command can be running at any given time and
> > > therefore they will complete in order? This would allow pipelining
> > > dependent commands but prevent long-running commands because the
> > > virtqueue is blocked while executing a command.
> > 
> > we have multiple vqs for that.
> 
> This reminds me of the async challenges with QEMU's QMP monitor.
> 
> Will it ever be possible to abort an in-flight command? I guess the
> abort command would need to be submitted on another virtqueue, but how
> do you identify the in-flight command that you wish to cancel?
> 
> Please clarify the blocking semantics in the spec because it wasn't
> clear to me.
> 
> Thanks,
> Stefan

I don't really get what does "blocking" mean. Nothing is required to
block I think.
I guess for abort it is still in order but a different vq
should not be needed.

Maybe we can use ID of buffer to cancel commands?

1. driver submits command as ID = 1
2. driver submits abort as ID 2
3. device sees the abort and cancels ID 2
4. device uses buffer 1
5. device uses buffer 3 - abort is complete

Device gets commands and processes them in order. It's just like scsi:
multiple queues, if you break it you get to keep both pieces.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

