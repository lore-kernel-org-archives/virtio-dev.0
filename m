Return-Path: <virtio-dev-return-13750-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2258CA5528
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 09:37:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 118442A82A
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 09:37:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD80F98663F
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 09:37:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C637A986632; Wed, 13 Sep 2023 09:37:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6181986634
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Sep 2023 09:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: YBDSFMewM9esZSrcE4XQxA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597851; x=1695202651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzkssuQ3acejbSy7nHEaJhrYEovcJbEvo8blJaSUV8c=;
        b=UGabbWAhyU4Luy7S+pADn4m1LuSx1nRBYZiQ8bMFmW0I2hsz3DCiAQVvzHzQpTBdvJ
         8qR0egj1cvUZYLbaAFgIj0w0ScbKJ7E+qp5JqIw04ULh2aEwITzbTSd8LTV/yNTZz0oD
         ai8cHvez2AhegCoD9MUlchvq6swNHgxdFSe2M7GUQ+WdUO+/0pelnte5oFJ0CrsX87vK
         i6P7tF8Hrf4CAOTXoA2jEeWwdz67FJrBNE4UQlV8uBYEDq+PffXX1jxejxqpjFRMOLSs
         b/2EIEiWMArSDS3/BJ+LiVXkNd8jHZtj3iw2lGX6l77uTVrbGc4NWtOlG08tmdM/Jnx3
         BIJw==
X-Gm-Message-State: AOJu0Yygxay3AjjNdwWX+o7h6Fy9f/qHBcPPJnmc5xr5edoqmpNDoKL9
	Lm5CcJ7Jf/l9JHrq1Q3fsT3VT9Qtk8eNDh3ThOeQD5oe2zeM5zji6/TLgFfa90BIhUVylupTVM9
	xHgnStQlIUmQFRtnN5hRY8g25LfB5
X-Received: by 2002:a17:906:1006:b0:99b:dd1d:bc58 with SMTP id 6-20020a170906100600b0099bdd1dbc58mr1599913ejm.41.1694597851557;
        Wed, 13 Sep 2023 02:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPujhlHmTPM9rQrI0wegkgVIJWcBQgdF3bKBhd3U+CWaFpkxLUIRobnfTrSwjd6I3V47D5mA==
X-Received: by 2002:a17:906:1006:b0:99b:dd1d:bc58 with SMTP id 6-20020a170906100600b0099bdd1dbc58mr1599900ejm.41.1694597851234;
        Wed, 13 Sep 2023 02:37:31 -0700 (PDT)
Date: Wed, 13 Sep 2023 05:37:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Babis Chalios <bchalios@amazon.es>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, aams@amazon.de
Message-ID: <20230913053707-mutt-send-email-mst@kernel.org>
References: <20221121162756.350032-1-mst@redhat.com>
 <20221121162756.350032-4-mst@redhat.com>
 <0abb7518-16e0-4227-bfe1-a29bd27124e8@amazon.es>
 <20230912170032-mutt-send-email-mst@kernel.org>
 <e738e7f0-dd13-44db-806c-543746aa6967@amazon.es>
MIME-Version: 1.0
In-Reply-To: <e738e7f0-dd13-44db-806c-543746aa6967@amazon.es>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

On Wed, Sep 13, 2023 at 11:32:57AM +0200, Babis Chalios wrote:
> > I do not understand why this matters though. we know there was a leak,
> > why does it matter whether there was one or two leaks?
> >
> > > In the last RFC implementing this in Linux we sent to LKML [1] we avoid
> the
> > > issue by pre-populating both
> > > queues, but that does not solve the problem if a third entropy leak
> event
> > > arrives. The probability of this
> > > happening is indeed small, but we thought of a potential solution to
> this.
> > >
> > > What if we modify the spec here to instruct the VMM to deny taking a
> > > snapshot if there are not any buffers
> > > in the active leak queue? If we did this, we could even simplify the
> spec to
> > > just introduce a single entropy
> > > leak queue, so we could avoid the complexity of switching between active
> > > leak queues in the driver and
> > > the device. WDYT?
> >
> > here's the problem:
> >
> > - driver adds batch 1 of buffers
> > - leak
> > - device starts using buffers from batch 1
> > - driver sees some buffers and starts adding batch 2
> 
> If understand this clause:
> 
> > > +\item Upon detecting that buffers have been used, driver
> > > +      switches to another leak queue making it active
> > > +      (e.g. from \field{leakq1} to \field{leakq2} or vice versa).
> > > +      It then starts adding buffers to the new leak queue.
> 
> correctly:
> 
> At this point, the driver will first switch active leak queue and
> then add batch 2 to the new leak queue.
> 
> and due to this:
> 
> > > +\item Device will keep using buffers in the active leak queue
> > > +      until it detects that both the current leak queue is empty and
> another
> > > +      leak queue has buffers. At that point device switches to
> > > +      another leak queue, making it active.
> > > +\item After the switch, buffers from the new leak queue are not
> > > +      used until an information leak is detected.
> > > +\end{enumerate}
> 
> the following won't happen:
> 
> > - device sees batch 2 and thinks this is part of batch 1
> >    consumes them all
> 
> Does it make sense?
> 
> Cheers,
> Babis

yes, the queue switch is used as a barrier to detect a new leak event.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

