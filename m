Return-Path: <virtio-dev-return-12100-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9F6C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:04:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D6CBB2AD54
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:04:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAFC09863C9
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:04:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A14F798632A; Mon, 10 Apr 2023 20:04:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 559B0986366
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 20:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: c7htIrztMqyz2AvbhoLlAw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWqO8lZwvoIfHBPLApzezXCaGPErmPUZqXD5VxgPQl4=;
        b=GZD3fMni/xMZ5n6bzJg73NcPkAyjn2jQ1Boz6U0fnQS7Gn9vlivQMSBAzaDmOpKrcA
         BFemTEv+k9MtO8CeVAkLI1N8OK81dZ0Y5qQnPQtmkWiO7U+5+Q3at8v5JgTVrohmSUB9
         BxPH/gapgYghIAqjz2t6DBM7x1meLSSSK39POB9G0WkVNcIfe6TA9wIiEu2WMyZmloSc
         hHg5z1DszsP9UvbvRNb767W/hvtfwH0JVKUMnbXZxwif/xQSw9+dQzclAUqgnY4hN69u
         /sg8Rty28VQ9Q9argxAWhlfJ0SLLBzVkq019ASnRw5/Sh/S4erhcq626iOhCM2NKtnz6
         Xp5w==
X-Gm-Message-State: AAQBX9fvcLBCQP8YJKB4dp6Qp3SRDwULZBRGqrXt+GkzeXhhB8pq18Fv
	tCHbKLa5vrM+aHoedTHhpj85112bQ/EaY+5XiULms269U27MOgrsLARQlOZRXF4BmLM6Arhk/+T
	7HIY2B64JXYiR+AI09draf5BH+Q4P
X-Received: by 2002:a1c:4b06:0:b0:3ee:6cdf:c357 with SMTP id y6-20020a1c4b06000000b003ee6cdfc357mr7283301wma.20.1681156988085;
        Mon, 10 Apr 2023 13:03:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350YYnNepyLMLMpTl2piXvLvkUKXtKKi83ZalM0N9AxceBV5+YW2dpzkH8bUj8TbGGeQwArT/6g==
X-Received: by 2002:a1c:4b06:0:b0:3ee:6cdf:c357 with SMTP id y6-20020a1c4b06000000b003ee6cdfc357mr7283292wma.20.1681156987753;
        Mon, 10 Apr 2023 13:03:07 -0700 (PDT)
Date: Mon, 10 Apr 2023 16:02:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230410155819-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <87jzysjd4g.fsf@redhat.com>
 <20230404084126-mutt-send-email-mst@kernel.org>
 <878rf7kcna.fsf@redhat.com>
 <20230404102053-mutt-send-email-mst@kernel.org>
 <fce3c697-55a6-1410-2f42-db6499bd8f87@nvidia.com>
 <20230410154518-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548109DAABB563E4DA3040CADC959@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548109DAABB563E4DA3040CADC959@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Mon, Apr 10, 2023 at 07:57:08PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 10, 2023 3:49 PM
> 
> > Attribution is nice but Signed-off-by is not that.
> 
> Then what is Signed-off-by for virtio spec?

we never defined it. using it kind of by 

> Can it be same definition as what Linux kernel and many other projects use like [1]?
> 
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed%20off

That is DCO. useful for linux pointless for us as is since
we want people to agree to our IPR.
Unless you want to make DCO refer to our IPR.
That might be possible.
We will need to float this past OASIS stuff.
I prefer explicit agreement to license personally.

> > And fundamentally people go read the PDF where the Signed-off-by does not
> > appear at all no one pokes at git history.
> When people read PDF, they do not care about the sign-off. Signed-off-by is not for that.
> 
> > Let's just do:
> > 
> > Thanks-to: name <email>
> > 
> Why to now learn a new term?
> Why terminology of [1] is not enough like AQ status codes? :)

I have no idea what problem you are trying to address.
If it is attribution Signed-off-by is not that.
If it is IPR Signed-off-by is not that either but might be
made to imply that.

> > if you want attribution.
> > 
> > will be helpful to fill in the thanks section in the spec and does not mention
> > signatures.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

