Return-Path: <virtio-dev-return-13802-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E1EC46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 13:58:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CD99B66DCC
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 13:58:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4B849864D1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 13:58:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88E399863AD; Mon, 18 Sep 2023 13:58:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 778E99863D8
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 13:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2WEzVV-CNyaOdi8MsLpJxQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695045496; x=1695650296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1AUMkWvTmMmys+T5UFiGPqDceeIKgcm5043Pwg+x2A=;
        b=Rtdz9pjwXj4pB83Fuv8m+8P9k4IezUdxAgXDwKldnaMeDaN6VEd06GxOE8SiMEG0Mp
         p7lung4C99FIbjhspjt7vdRTBI8MaQSqh4Flh61YPz2l6DUINpUepe6z9EkquXmv9DWH
         1bIGsyqIHYtorvRtj4pwXYzAjhIK1gclvXMDjOo5fXlIbVJc88gDG1INEHX+fqMRJyGj
         1LVDQueIhr7thxkvQe0yTnlxqhN+L0vsnBYLqzE2gPQOU823unuamz9z40OKTMYUMJ+n
         KmpvedYxwwPKFrFBoIleQYmfsZ1DC/bYCKaqxEE3XomHAmPIvj4H0K0OWe3M/FoFOV74
         gklg==
X-Gm-Message-State: AOJu0YyhkTmRxhhtR0Aozt3+H1LCIhixH8V/EnH5zdRiXNxStRqVEUBv
	zNnCKu/8NnBGRETqyu/YbA3S13PfLak0qoU9B94AIp7RLKyJSFQIk2qWpUGnAJ75XS8O9GQC5kG
	4m0wIdThBvFjdtYMdtTpf1JCGcGvR
X-Received: by 2002:aa7:d3d4:0:b0:51d:9399:4707 with SMTP id o20-20020aa7d3d4000000b0051d93994707mr6489636edr.26.1695045496305;
        Mon, 18 Sep 2023 06:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjToxxXc4aKG++5hXac5eU5TkUidfitlStHDnvkrsB6JDi3UaKp8vr3JZ/Sk4ugmrhFwd/eg==
X-Received: by 2002:aa7:d3d4:0:b0:51d:9399:4707 with SMTP id o20-20020aa7d3d4000000b0051d93994707mr6489625edr.26.1695045496029;
        Mon, 18 Sep 2023 06:58:16 -0700 (PDT)
Date: Mon, 18 Sep 2023 09:58:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Babis Chalios <bchalios@amazon.es>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, aams@amazon.de
Message-ID: <20230918091506-mutt-send-email-mst@kernel.org>
References: <20221121162756.350032-1-mst@redhat.com>
 <20221121162756.350032-4-mst@redhat.com>
 <0abb7518-16e0-4227-bfe1-a29bd27124e8@amazon.es>
 <20230912170032-mutt-send-email-mst@kernel.org>
 <e738e7f0-dd13-44db-806c-543746aa6967@amazon.es>
 <20230913053707-mutt-send-email-mst@kernel.org>
 <d7d17e9f-e6ad-4106-a408-99281382a93f@amazon.es>
 <20230918083722-mutt-send-email-mst@kernel.org>
 <e75d9667-2ea0-44d0-a26f-fa3d5fe05651@amazon.es>
MIME-Version: 1.0
In-Reply-To: <e75d9667-2ea0-44d0-a26f-fa3d5fe05651@amazon.es>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

On Mon, Sep 18, 2023 at 03:00:43PM +0200, Babis Chalios wrote:
> 
> > > Right, so I think that there is a race condition between the time the driver
> > > sees the used buffers of the first
> > > batch and until it adds the second batch on the next leak queue.
> > > 
> > > 1. driver adds batch 1
> > > 2. leak event
> > > 3. device uses batch 1
> > > 4. driver sees the used buffers and
> > >      a. switches leak queues
> > >      b. adds batch 2.
> > > 5. devices finds initial leak queue empty and sees buffers in second leak
> > > queue.
> > > 
> > > If a second leak event happens after step 3 above and before all of steps 4
> > > complete then batch 2 will not
> > > be processed as part of the second leak event.
> > driver can just pre-add buffers in the second queue.
> > 
> > 1. available buffers to queue 1-X
> > 2. available buffers to queue X
> > 
> > 
> > 3. poll queue X
> > 4. used buffers in queue X
> > 5. avail buffers in queue X
> > 6. poll queue 1-X
> > 7. used buffers in queue X
> > 8. avail buffers in queue X
> > 9. goto 3
> > 
> 
> Yes, that's what the driver does now in the RFC patch. However, this just
> decreases
> the race window, it doesn't eliminate it. If a third leak event happens it
> might not
> find any buffers to use:
> 
> 1. available buffers to queue 1-X
> 2. available buffers to queue X
> 
> 
> 3. poll queue X
> 4. used buffers in queue X       <- leak event 1 will use buffers in X
> 5. avail buffers in queue X
> 6. poll queue 1-X                <- leak event 2 will use buffers in 1-X
> 7. used buffers in queue 1-X
> 8. avail buffers in queue 1-X
>                                  <- leak event 3 (it needs buffers in X, race with step 5)
> 9. goto 3


I don't get it. we added buffers in step 5.

> 
> 
> If, instead, we define a single leak queue and require that VMM should refuse to take a snapshot
> if that queue is empty, we avoid the race condition in all cases and IMHO the protocol becomes
> much simpler.
> 
> 
> Cheers,
> Babis
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

