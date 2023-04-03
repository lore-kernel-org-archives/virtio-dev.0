Return-Path: <virtio-dev-return-11930-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC46EC77B62
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:06:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1EA2F2B040
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id 0874A2A8C7; Mon,  3 Apr 2023 20:06:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D0099863EF
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 20:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hy5f_98oMeCsRv2h3OaxjQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIUF8S/Oc1LcFuJk+VZKA5lFbPuTetDchJil3yqg/uk=;
        b=D0ZFeQcs942Hu0oOTGBsxgDfQMid/xoPLd61KmOh9weAbSPB7jvUNCjMlUvdbsG3Dd
         ZzKbNHFBt8300zAjGuZDfStzdKbA+Fj+RJtTFjxdKrLJyHxkhMvbDmz6aM5z3RDwTLgp
         BKuH7em9JiThM7n2oNsVcSV4GEOWiHWawSV87MicC/6IqxzogeBsJnc00fbFP5hLB/2e
         luKBeld6DGd7kyQhoFRuvigTWk+Hn5QeU6pZmfsxCQdCmpV08fLEWGjc1os623qdGCDt
         Ibkd67eksYpnYnbS2UwScTlM4RQ/569fppinxY14RZD+GRBdlOsQ3+bZY6z1jX4JoU/9
         0WHQ==
X-Gm-Message-State: AAQBX9dGee6s9ij2k/xcUHae6VZWoti9MAwmCbugbVwQpnsm1Ysobuof
	XjNi+VGz9IHpQH5rTmyPvfokqh+JPB3iacATA0yXdicqb6WCh3bOKWhj6OsHyjsZI7AG81YbGFO
	8qIu6RYqU5FoavPtBiGwQpc5kCJrH
X-Received: by 2002:aa7:cd12:0:b0:4fb:7ad6:907a with SMTP id b18-20020aa7cd12000000b004fb7ad6907amr359950edw.13.1680552233552;
        Mon, 03 Apr 2023 13:03:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350YfbOkyPlUZ74gg5EJnkawoCyHLMSicc7xS5/+m0ItYHZPK42dBhTp2MM8oagSJIVMmRg+PGg==
X-Received: by 2002:aa7:cd12:0:b0:4fb:7ad6:907a with SMTP id b18-20020aa7cd12000000b004fb7ad6907amr359933edw.13.1680552233272;
        Mon, 03 Apr 2023 13:03:53 -0700 (PDT)
Date: Mon, 3 Apr 2023 16:03:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com
Message-ID: <20230403160309-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403134407-mutt-send-email-mst@kernel.org>
 <20230403191152.GB350467@fedora>
MIME-Version: 1.0
In-Reply-To: <20230403191152.GB350467@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device

On Mon, Apr 03, 2023 at 03:11:52PM -0400, Stefan Hajnoczi wrote:
> On Mon, Apr 03, 2023 at 01:48:46PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 03, 2023 at 10:53:29AM -0400, Parav Pandit wrote:
> > > On 4/3/2023 10:45 AM, Stefan Hajnoczi wrote:
> > > > On Fri, Mar 31, 2023 at 01:58:23AM +0300, Parav Pandit wrote:
> > > > > 3. A hypervisor system prefers to have single stack regardless of
> > > > >     virtio device type (net/blk) and be future compatible with a
> > > > >     single vfio stack using SR-IOV or other scalable device
> > > > >     virtualization technology to map PCI devices to the guest VM.
> > > > >     (as transitional or otherwise)
> > > > 
> > > > What does this paragraph mean?
> > > > 
> > > It means regardless of a VF being transitional MMR VF or 1.x VF without any
> > > MMR extensions, there is single vfio virtio driver handling both type of
> > > devices to map to the guest VM.
> > 
> > I don't think this can be vfio. You need a host layer translating
> > things such as device ID etc.
> 
> An mdev driver?

vdpa seems more likely. we can extend it to support legacy if we want
to.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

