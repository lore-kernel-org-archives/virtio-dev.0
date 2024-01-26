Return-Path: <virtio-dev-return-14278-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4CAC47422
	for <virtio-dev@archiver.kernel.org>; Fri, 26 Jan 2024 08:01:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C1B3B2AF7F
	for <virtio-dev@archiver.kernel.org>; Fri, 26 Jan 2024 08:01:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E9F298686F
	for <virtio-dev@archiver.kernel.org>; Fri, 26 Jan 2024 08:01:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 816B7986861; Fri, 26 Jan 2024 08:01:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DECD986863
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Jan 2024 08:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ET0TpZAJPFyuPxQHURKeRA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256076; x=1706860876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXimZfNwjPhYGgax7Th9a7MAq+8FMgfDeAwzsM2pXcI=;
        b=Ma0D5JNrxdIdJWcEFM/0mW13snZ7fScv/j9pw6rlrmgEZikaOT6s5PkcZL6vqdKHd/
         Ate+oPmEMTQUFHdanJzhhmTcpYoS7OakVnRazTJnRyswZwI487kK6UZd14TJB1XxwUcY
         GGxyw/suOMLorZv5vDgyix/MyVJ0P40N1HITN/2PCpai0nxcgkhE0BeW/QQt80tpCkxX
         rkaZkWA1WUwaM3wTSGMIUPQa1floLb/D77I69PlljVezeIxyafnKDFg8sHpLMXfldI2o
         Il8uWDBAV8CAXmiqGnUteFZq9Q8sJ+LSqJArHgPkyjbDh4ghkXz1LNit2C8WI13D/nwI
         TPNA==
X-Gm-Message-State: AOJu0Yy5XWmQVmLDZRE+v0b9EErT8gKExH4sDgm2d15yz3CEKLOv2q6T
	ZhuerkkUPXuHGJn6ucv0ixGXk78/PYwBLUEGyizroAilraOxQ1C9rugEJQOkYveKohb0HjIscPg
	bWsn3nxAld2VvRBITM210A9qbxT6KpymbOMIDrdHqyZ0g8Q0JLlBDlHClP02Wv+cYNw==
X-Received: by 2002:a05:600c:19cd:b0:40e:d1da:3d17 with SMTP id u13-20020a05600c19cd00b0040ed1da3d17mr388299wmq.54.1706256075957;
        Fri, 26 Jan 2024 00:01:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmGpnsahyoy0ENIwp9xMhWNwVQZsFEe9+U5wd6b1FNoE8zbZgLflFuKIdgahuSMY2KcwPx9g==
X-Received: by 2002:a05:600c:19cd:b0:40e:d1da:3d17 with SMTP id u13-20020a05600c19cd00b0040ed1da3d17mr388292wmq.54.1706256075583;
        Fri, 26 Jan 2024 00:01:15 -0800 (PST)
Date: Fri, 26 Jan 2024 03:01:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
Message-ID: <20240126025730-mutt-send-email-mst@kernel.org>
References: <ff9a6d805e7d510cde77b9989bef90aa21ffe4b4.1706094950.git.mst@redhat.com>
 <PH0PR12MB5481FF7AED1F50D7066AC16ADC7B2@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FF7AED1F50D7066AC16ADC7B2@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] [PATCH] virtio-net: clarify error handling for
 coalescing

On Wed, Jan 24, 2024 at 11:23:08AM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio@lists.oasis-open.org <virtio@lists.oasis-open.org> On Behalf Of
> > Michael S. Tsirkin
> > Sent: Wednesday, January 24, 2024 4:46 PM
> > To: virtio-comment@lists.oasis-open.org; virtio-dev@lists.oasis-open.org
> > Cc: virtio@lists.oasis-open.org
> 
> Can we please avoid posting to three different lists?

Yea I'll stop. Used to do it because of different archiving rules.
I'll stick to virtio-comment@lists.oasis-open.org


> > Subject: [virtio] [PATCH] virtio-net: clarify error handling for coalescing
> > 
> > This is not a huge deal since it's a SHOULD anyway, so make the new
> > requirement SHOULD too.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  device-types/net/description.tex | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/device-types/net/description.tex b/device-
> > types/net/description.tex
> > index aff5e08..d1d25fe 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -1792,7 +1792,11 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > 
> >  The device MUST ignore \field{reserved}.
> > 
> > -The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if
> > it was not able to change the parameters.
> > +The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR
> > if it was
> > +not able to change coalescing parameters. In this case, the parameters
> > +SHOULD remain unchanged, for all VQs.
> 
> Is the new added normative line without device is ok?
> 
> Or should it be written as
> ... In this case, the device SHOULD not update the parameters for all VQs.
> 
> ?

Your wording is confusing it can be intepreted to
mean just that not all parameters change but some might.
Generally we do not have to repeat "device" in each sentence.

> > +
> > 
> >  The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > command with VIRTIO_NET_ERR if it was not able to change the parameters.
> > 
> > --
> > MST
> For the functionality itself, ignoring above normative suggestion,
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

