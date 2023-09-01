Return-Path: <virtio-dev-return-13599-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D6CCA0FE5
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 14:45:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 056D3F3F7D
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 14:45:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEC819865FF
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 14:45:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9C5E598658E; Fri,  1 Sep 2023 14:45:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B9CD98667D
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2023 14:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7EHHoXuePdOOWqQk6SfyMg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693579530; x=1694184330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCu8tmRvxbC+9l/nnmdM8q11i2y1GsPOnvkr90V71kM=;
        b=GS2IXPnAxMnlSrzUUqbGsANFScboeW4O8Cl1eAq8e/YJe2E0DV2QR2EtNlKuDP4C2a
         gho0JgcInNBIogZQtCEZo8oETYoZ7/aDeZQPR2qZUXmq94Oqgh2ZzIt2eLLjNKORF1O1
         FHkcf51b1DOQaEFt3afi8X2oER9/J6V2OrZH99c3FPhPL6xkduMDmYqwMKovIilMHzy9
         +HF9ExjaYYQDSj/XPtQxtzOWJStCCbXOtTWSB+5V4P7ahhIHQflrEiWkCywr9oyWVMR0
         pfMVP82qDkaOdOFiEj7BFx8B6QEQGoKcdqriBKMjC9jgDi7eAxxHcwdLJJzADQ2nSDfS
         dYKw==
X-Gm-Message-State: AOJu0YwaCcyKV4L3O9hbC2QHT3uMO4xgAgA7ORaMytLqVpEu9iX7Pgx4
	5ayjsSLnfGf0LR1y1A4SIaa7ZcQA98TsqAGEQ+CzW0K8jGuv838AJDoypoVCPS5QUSLYwBO72xy
	WXK3YChtlUcDvYXrBrb4Eq9UbiP6V
X-Received: by 2002:a2e:b0f0:0:b0:2bd:1681:e8dc with SMTP id h16-20020a2eb0f0000000b002bd1681e8dcmr1754861ljl.53.1693579530536;
        Fri, 01 Sep 2023 07:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQB8y9g7ph92mwjUJrjm0F67dVnQZHOKm6mgC/Lbv11pU3kZoZfxyVWs0bwmBe+7ryCnRzOw==
X-Received: by 2002:a2e:b0f0:0:b0:2bd:1681:e8dc with SMTP id h16-20020a2eb0f0000000b002bd1681e8dcmr1754849ljl.53.1693579530185;
        Fri, 01 Sep 2023 07:45:30 -0700 (PDT)
Date: Fri, 1 Sep 2023 10:45:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Message-ID: <20230901103735-mutt-send-email-mst@kernel.org>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v16] virtio-net: support device stats

On Fri, Sep 01, 2023 at 01:58:32PM +0000, Parav Pandit wrote:
> 
> 
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Wednesday, August 30, 2023 11:23 AM
> > To: virtio-dev@lists.oasis-open.org
> > Cc: jasowang@redhat.com; Michael S. Tsirkin <mst@redhat.com>; Parav Pandit
> > <parav@nvidia.com>; David Edmondson <david.edmondson@oracle.com>;
> > virtio-comment@lists.oasis-open.org
> 
> We should be following [1].
> Virtio list for conducting technical committee work, which is this patch.
> And to get feedback from community virtio-comment list, which you already CCed.
> 
> So virtio-dev should be replaced with virtio list because this patch is about developing the virtio spec itself, (not implementing the spec in device/driver etc).
> 
> [1] https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback


No, virtio-comment was already CC'd, and I think it's the best list for
comments (this is how we classify patches, technically) since anyone can subscribe
to that one.

We use virtio mostly for discussion about release schedules, voting,
bylaws and other issues not of interest to TC non members.


Removing virtio-dev is a good idea, copying both is really not necessary.

...

> > +    \item [rx_drop_busy]
> > +        This is the number of packets dropped by the device when the device is
> > +        busy.
> > +
> I think the busy counter does not belong to busy category as it is slightly difficult to define.
> Lets please move to different category.

Or better define it better. What does "busy" mean? I suspect basically
our of internal resources?
> > +    \item [rx_csum_bad]
> > +        The number of packets with abnormal csum.
> s/abnormal/wrong
> 
> no strong opinion though.

checsum mismatch.
avoid abbreviation


> > +
> > +\end{description}
> > +
> > +\subparagraph{Transmitq CSUM Statistic}\label{sec:Device Types /
> > +Network Device / Device Operation / Control Virtqueue / Device
> > +Statistic / Transmitq CSUM Statistic}
> > +
> > +The structure corresponding to the transmitq csum statistics is
> > virtio_net_stats_tx_csum.
> > +The corresponding type is VIRTIO_NET_STATS_TYPE_TX_CSUM. This is for the
> > transmitq.
> > +
> > +Only after the VIRTIO_NET_F_CSUM is negotiated, the transmitq csum
> > +statistics can be obtained.
> > +
> > +The following are the transmitq csum statistics:
> > +
> > +\begin{lstlisting}
> > +struct virtio_net_stats_tx_csum {
> > +    struct virtio_net_stats_reply_hdr hdr;
> > +
> > +    le64 tx_csum_none;
> > +    le64 tx_needs_csum;
> > +};
> > +\end{lstlisting}
> > +
> > +The packets described below are all from a specific virtqueue.
> > +\begin{description}
> > +    \item [tx_csum_none]
> > +        The number of packets which didn't require hardware csum.
> > +
> The number of packets which requires checksum calculation by the device.

which require - it's not the number that requires checksum it's the
packets that require it.

...

> > +The device has the allowance for the speed. If
> > +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get this by
> > \field{speed}.
> > +When the real speed exceeds the speed allowance, some packets will be
> > +dropped by the device.
> > +
> Above description regarding "real speed" is confusing.
> I think you wanted to say,
> 
> When the received packets rate exceeds the negotiated speed, some packets may be dropped by the device.

negotiated how?

yes, I don't understand what this does, either.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

