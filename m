Return-Path: <virtio-dev-return-11453-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96807C6FD1A
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:37:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C9CBD76068
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:37:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE2AF9866C4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:37:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B24479866BD; Mon,  6 Mar 2023 18:37:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A24799866BF
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 18:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: R_XI--CEOOGR_0Kg_oMfSQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUWErxNPrUrIMv2QbGRSFvzl2G28V2kvcbsO7YO7Kg0=;
        b=3vTiEPTr0NNEivoISNHRq0yeMTdqXsK+x4aGyb4WLvHacC3XNLIZTCViMCtQtALdBu
         jqB+R+GV2E5jg4xPFhuYw6+ce2E2LxjZK6d+BnyfWgcKOVtRIjGrWOEqxOqb81qnWKzC
         jSMEWUv+7YNzOEEH7NPpGyXlnNAuMrk7X46V+CKjvQAWQpeC4iIazbjwTFmY1XsW1+Zv
         EwyOqsIDbYZe4Ggagr29YGlCctAvE8x2f1nlk8JZBmhaIwYolGSDBNM0nqtDAVZ6OjWc
         Ia6wTmAudeq39Dx8oZ/AD1JPUfP7mhgSPzWv3QwRmU14b4c6CXvZubWRHuCgPbpdFDjz
         2s7Q==
X-Gm-Message-State: AO0yUKVH4L+En0D8HcHpQvtkbDh2vht4p6U6l1XfLybafVxyjPyXlIt0
	DN6S+iYrPvQGD56PX887z/pD44MC7RRnPNhhvElT4zQ2ayQ+aKr97dSG3nGjPwueEg4umVHFGmM
	7QtuYWsV8Ex1UIMZG0Crp0LzeF1Bb
X-Received: by 2002:a05:600c:3b0c:b0:3eb:2b88:999f with SMTP id m12-20020a05600c3b0c00b003eb2b88999fmr9887596wms.5.1678127856112;
        Mon, 06 Mar 2023 10:37:36 -0800 (PST)
X-Google-Smtp-Source: AK7set+pfueUoTftA7cCbkxlmh7uF0V/CpSd6IjoWMj0zckWOgYt3Z+Ok+5HFp4Hrghly0Ye4rD4WA==
X-Received: by 2002:a05:600c:3b0c:b0:3eb:2b88:999f with SMTP id m12-20020a05600c3b0c00b003eb2b88999fmr9887577wms.5.1678127855839;
        Mon, 06 Mar 2023 10:37:35 -0800 (PST)
Date: Mon, 6 Mar 2023 13:37:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230306133525-mutt-send-email-mst@kernel.org>
References: <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
MIME-Version: 1.0
In-Reply-To: <20230306110340.GA35392@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
> On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
> > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
> > > > > What happens if a command takes 1 second to complete, is the device
> > > > > allowed to process the next command from the virtqueue during this time,
> > > > > possibly completing it before the first command?
> > > > > 
> > > > > This requires additional clarification in the spec because "they are
> > > > > processed by the device in the order in which they are queued" does not
> > > > > explain whether commands block the virtqueue (in order completion) or
> > > > > not (out of order completion).
> > > > 
> > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
> > > 
> > > virtio-scsi, virtio-blk, and NVMe requests may complete out of order.
> > > Several may be processed by the device at the same time.
> > 
> > Let's say I submit a write followed by read - is read
> > guaranteed to return an up to date info?
> 
> In general, no. The driver must wait for the write completion before
> submitting the read if it wants consistency.
> 
> Stefan

I see.  I think it's a good design to follow then.

I'll just copy
	The driver queues requests to an arbitrary request queue, and
	they are used by the device on that same queue. It is the
	responsibility of the driver to ensure strict request ordering
	for commands placed on different queues, because they will be
	consumed with no order constraints.

replacing "request" with "admin".

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

