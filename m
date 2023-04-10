Return-Path: <virtio-dev-return-12088-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B043C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:25:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DCC8041F15
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:25:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D52559863A7
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:25:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CAA559862A5; Mon, 10 Apr 2023 13:25:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB03C986319
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 13:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6N5pIRoqPh-gswdB0ApxGw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681133115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCI17d53vZjtXSGxUMp5ipR9eY6/RkK+6gZEGfMqMSg=;
        b=oo1gnvFFV8X5UKWLa60r7yiZkJB1nTZb6p3fNUdRjh6c7EobfDJDotO/VGGLoGj/8F
         XRhJYPTZchuC6MwBC7tkV8CXj29nDdWqm61NpdKX72LQzGHRCMvGHZ1a5jgtNSz4fe0T
         dWYQSgkDJIC8x7YD8S6kOYjGBcfWd2fuJhA8QvTwstkuuzKKtNuhGq/Fg2O8y8ey8/lx
         wHXbmzZIyd+79bkerp3RWhPhzxQ7AQ/rRvibZVoY5ba+cJ7bW0HofGT0LTdiL4qcRsa3
         HbKh6FJ0JQt4ECxqpoBjEE9s5yoXbhMjENCAGeT5khlOiO4AcwKzWrZKkftwCHDeksMD
         Bp4Q==
X-Gm-Message-State: AAQBX9cyaU4NXc29gjmDnpsHzk+IcKDviKrMObTiGGoEj9BbmSDGaLPI
	XXdjEw6uETBnvxKZlCWBTYrO7Tq9Zm3UorSgWweR2vJowBb35g69qP8lVD1i3Ek38k3vGgwNu7I
	Yh4hTeAyec0mW6ctY/Dfaeq/MERDH
X-Received: by 2002:a05:600c:2050:b0:3eb:39e0:3530 with SMTP id p16-20020a05600c205000b003eb39e03530mr6749747wmg.41.1681133115477;
        Mon, 10 Apr 2023 06:25:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350bx7DlmEX+FexrvcVXMcy7jGpleMaAES32dWORfxR6GmUURQDUrOxW6WBkY8Gqo7lE7GkVyfg==
X-Received: by 2002:a05:600c:2050:b0:3eb:39e0:3530 with SMTP id p16-20020a05600c205000b003eb39e03530mr6749733wmg.41.1681133115184;
        Mon, 10 Apr 2023 06:25:15 -0700 (PDT)
Date: Mon, 10 Apr 2023 09:25:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230410092356-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405011326-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ACE86E296DF21D942C1DDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481ACE86E296DF21D942C1DDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 03/10] content: Rename confusing queue_notify_data
 and vqn names

On Wed, Apr 05, 2023 at 01:20:04PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 5, 2023 1:22 AM
> > 
> > This is not much of an improvement.
> > 
> > On Wed, Apr 05, 2023 at 04:06:50AM +0300, Parav Pandit wrote:
> > > Currently queue_notify_data register indicates the device internal
> > > queue notification identifier. This register is meaningful only when
> > > feature bit VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
> > >
> > > However, above register name often get confusing association with very
> > > similar feature bit VIRTIO_F_NOTIFICATION_DATA.
> > >
> > > When VIRTIO_F_NOTIFICATION_DATA feature bit is negotiated,
> > > notification really involves sending additional queue progress related
> > > information (not queue identifier).
> > >
> > > Hence
> > > 1. to avoid any misunderstanding and association of queue_notify_data
> > > with similar name VIRTIO_F_NOTIFICATION_DATA,
> > >
> > > and
> > > 2. to reflect that queue_notify_data is the actual device internal vq
> > > identifier, rename it to queue_notify_id.
> > >
> > > Reflect vq identifier in the driver notification structure by renaming
> > > ambiguous vqn to vq_notify_id.
> > >
> > > The driver notification section assumes that queue notification
> > > contains vq index always. CONFIG_DATA feature bit introduction missed
> > > to update the driver notification section. Hence, correct it.
> > >
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > >
> > > ---
> > > Some side notes:
> > > renaming vqn to vqnd is even more confusing because data is really the
> > > queue identifier.
> > 
> > Clear to whom?  Why do you think so? Marvell who pushed this feature said
> > they stick some kind of constant value there which matches what their
> > hardware expects. Sounds like a valid way to use this.
> Spec currently has described it as "identifier".

Nope, it gives an identifier as one example of a legal value.


> Snippet:
> "for example an internal virtqueue identifier,
> or an internal offset related to the virtqueue number"
> 
> > So no, not an identifier, and in any case "vq identifier" is a really general and
> > useful term, I would rather not burn it up on a baroque feature that almost no
> > one sets - for almost everyone else this is simply vq index.
> > 
> > If you really insist on renaming this away from "vqn", maybe
> > vq_index_config_data will do, and we can add a comment /* Either vq index or
> > vq config data, previously named vqn */
> > 
> Vq_index_config_data also aligns with the crazy feature bit name.
> So I will use that.

:)

It's just standard thing you get if you overload fields. And this
is data path we could not just add fields easily.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

