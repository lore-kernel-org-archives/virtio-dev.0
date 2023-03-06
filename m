Return-Path: <virtio-dev-return-11458-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B7BC64EC4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 21:44:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D42341318C2
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 21:44:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BEE7B9866C9
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 21:44:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B0016983C2D; Mon,  6 Mar 2023 21:44:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AD739866C1
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 21:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: may8pab_MYKc-5YQD9lU9g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678139041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OY/rntB86FytA/6O5zjv5r2vzqTbNde/PGe0CGx4/w=;
        b=mI7+AW+79X7g2r87kpGHXSxAgqQsMiqXOh+JBE4/dsxvXFb+NHQa/IbFWhRXKNqqDS
         wWiF2R8c+r1R9rYcwMexeS/YAYgAXtufprIbypRiuFuFOvoemaijbfkCke2bKK4+ytTe
         RibokaaZgnv5sAckLVmT4Veqw0C6G2wAa9tdYuKAMr3noQGxN/vz/grc6iJm0qJn154l
         wJE5v/eSzjR4uJAfokQw4af6/LPDlncPkbI1YVDT8bdDuj9hD86BjT2VPZfjZ4pDq5Xs
         GsepGKYidelHHD9iK2TgsDVFij4YJ0Z6jJkOIP15y3S4eSAx1vxt/hie5vQVC3C2qjk9
         88Lw==
X-Gm-Message-State: AO0yUKUbgOy0vcszLFDoj+m11EBMsoOm6ukHiM1+2TC4i0q9zITP10oC
	VWAQK2Z7e3i/+uc6TugrG6fgY0MXfi9hfVyEGPOthU3ajPqj267KgowU9hwSPGrwLIu1rMwI+Z8
	CZLCkH2r/xReHtdZa5kqfvDPRO2AO
X-Received: by 2002:a5d:4ac6:0:b0:2c5:4ca3:d56c with SMTP id y6-20020a5d4ac6000000b002c54ca3d56cmr11301192wrs.0.1678139041297;
        Mon, 06 Mar 2023 13:44:01 -0800 (PST)
X-Google-Smtp-Source: AK7set9SY3iOgrw3AyFW7DWcKjQr4SHvayzBNTWamAOSIOOPgDzdmCg5DkDyR4mjrnKDxoHWzX4sBg==
X-Received: by 2002:a5d:4ac6:0:b0:2c5:4ca3:d56c with SMTP id y6-20020a5d4ac6000000b002c54ca3d56cmr11301176wrs.0.1678139040976;
        Mon, 06 Mar 2023 13:44:00 -0800 (PST)
Date: Mon, 6 Mar 2023 16:43:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230306163955-mutt-send-email-mst@kernel.org>
References: <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <20230306201759.GA78491@fedora>
MIME-Version: 1.0
In-Reply-To: <20230306201759.GA78491@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

On Mon, Mar 06, 2023 at 03:17:59PM -0500, Stefan Hajnoczi wrote:
> On Mon, Mar 06, 2023 at 01:37:31PM -0500, Michael S. Tsirkin wrote:
> > On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
> > > On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
> > > > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
> > > > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
> > > > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
> > > > > > > What happens if a command takes 1 second to complete, is the device
> > > > > > > allowed to process the next command from the virtqueue during this time,
> > > > > > > possibly completing it before the first command?
> > > > > > > 
> > > > > > > This requires additional clarification in the spec because "they are
> > > > > > > processed by the device in the order in which they are queued" does not
> > > > > > > explain whether commands block the virtqueue (in order completion) or
> > > > > > > not (out of order completion).
> > > > > > 
> > > > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
> > > > > 
> > > > > virtio-scsi, virtio-blk, and NVMe requests may complete out of order.
> > > > > Several may be processed by the device at the same time.
> > > > 
> > > > Let's say I submit a write followed by read - is read
> > > > guaranteed to return an up to date info?
> > > 
> > > In general, no. The driver must wait for the write completion before
> > > submitting the read if it wants consistency.
> > > 
> > > Stefan
> > 
> > I see.  I think it's a good design to follow then.
> > 
> > I'll just copy
> > 	The driver queues requests to an arbitrary request queue, and
> > 	they are used by the device on that same queue. It is the
> > 	responsibility of the driver to ensure strict request ordering
> > 	for commands placed on different queues, because they will be
> > 	consumed with no order constraints.
> > 
> > replacing "request" with "admin".
> 
> That sounds like it's only about multi-queue because it says "... for
> commands placed on different queues". What I mentioned about a write
> followed by a read quest also applies within a single queue.

Well that text is from the virtio scsi spec. turning it around does
it need clarification there?

> Can you clarify the semantics in the single queue case?
> 
> Stefan



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

