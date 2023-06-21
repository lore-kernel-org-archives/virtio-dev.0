Return-Path: <virtio-dev-return-13024-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED2DEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:17:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18DB155C7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:17:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A7E49865DB
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:17:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F3763983DDB; Wed, 21 Jun 2023 20:17:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E11649865CE
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 20:17:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: EQYFax3rOi6YWYF6kzMZrA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378604; x=1689970604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDd2HAAraecmTTS7+CAYLdh14y7aVFdbcLiVqDYah+k=;
        b=TTNVlE+ACVoyehLqW8bHsDnG46eSFY7wa9ARsHpBWAiDtpKwITtTJsIKb+lxZw1UP3
         6oyfQCbaK23rmxIb6bsMilc6c8IBBetXJgljifl4dRgsR2LMwtHOEWK7pUhNp5QV5H6S
         l3gZ87XzNgoDIZHhgeAwqxN+5lwCHnHXeZkOHslYcsM06SB7ejhclgjoWByU9MnzJk4C
         vY1pHxJzlXp4HJnQKoASpD1Ocg8D6c84j7gt63TcsVuxhBsEvBUvN93UI1FkuzESUbAv
         i75H4rAEmwosvaC9aAJjahW9liwh9slSmNyZct18XK+8yIbeAXThuPsdQlAsByXJTIIf
         t/yQ==
X-Gm-Message-State: AC+VfDxCN4GTxx6qdyEUN0XQqLOoRph6XCW0wpWnjhIl3zS3CXYTwHYP
	J481rh/1NPNh7B6vy91mAO1vVqyarFb9hIyaT+5T5dz9aFoM/jBZsKqVA+001YYjp8X1EMO2HB4
	QrOIlPTlSUpdklKaFCs72y/Ee3HeT
X-Received: by 2002:aa7:d1c9:0:b0:51a:3204:fb09 with SMTP id g9-20020aa7d1c9000000b0051a3204fb09mr4165155edp.26.1687378604181;
        Wed, 21 Jun 2023 13:16:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sftoWnYTAa7mnd9yOkSqVxniLfViWaRDNpaaDT4P4T9lAI8LYI1FF+GR9tWxc3qUZ0kQyPg==
X-Received: by 2002:aa7:d1c9:0:b0:51a:3204:fb09 with SMTP id g9-20020aa7d1c9000000b0051a3204fb09mr4165151edp.26.1687378603926;
        Wed, 21 Jun 2023 13:16:43 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:16:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230621161157-mutt-send-email-mst@kernel.org>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 21, 2023 at 07:37:00PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 21, 2023 3:32 PM
> 
> > 
> > Well RSS is designed (imho) better since it keeps the supported types in config
> > space. Doing it here would have removed the need for GET command.
> > Yes I know Parav hates config space, no I don't think for a read-only field like
> > this one this hate is justified.
> > Did we discuss this and decided not to add it in config space for some reason? I
> > don't remember ...
> > 
> Yes, we discussed this in v12 or before to have symmetric interface to have it via get and set via cvq.
> Should be there in the change log.

Oh good point, it is in commit log. Heng Qi, thanks for writing such a
nice detailed commit log!

Here is what you wrote:
	Given that a set command is added via cvq, it make sense to also do 
	symetrric work to get it via a cvq.

and actually I missed the fact that instead of making this
symmetric it forced separate structures for GET and SET.

If we move supported_tunnel_hash_types back to config space
then GET and SET just need the active bitmap. *that* seems
symmetric to me.

And the field is RO so no memory cost to exposing it in all VFs.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

