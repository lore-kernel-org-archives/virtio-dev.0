Return-Path: <virtio-dev-return-13015-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D777EB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:35:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D67A02B12F
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:35:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B64249865D5
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:35:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D8FE9865BA; Wed, 21 Jun 2023 19:35:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 888D49865C1
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 19:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8UAYRYgNP02Ff5YOKXWMVQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376151; x=1689968151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBkAeXciafu3w0TWzsDfncwLro1e8fXKMm7HYn4DPkU=;
        b=EJHM91+mub3YwVKyfQX/QCdNRvAXsBw96OtFRec9BGWc/C+E+uk/ZTzyCuleqkcxwW
         AnaaluIz8SJAei3pGIaE5OYBEaVJAgpmQQZLHlBRrJEBxLDZ4cnWVkB3crN7SlqTvmXi
         eu9AtraZBynDDkArxBISIXHG83xNPmCqEu+RiunmKAiRuzN6zarPfzl9SaAAOJ4QqcN/
         ErpXyDIE25kkNtvFHoEQA1mf6PfvpnodMCgcmjKiAKgkglpqlmEDnn6z52YNBge0tEN5
         DY/fu6xWHEoYq/5r4LcTZRIR18h8ZenQbNrXioaFV9IwkepnPYlwmfYT0Snqm6QpY7z1
         l0lw==
X-Gm-Message-State: AC+VfDypygW1YU4ALoYrjXp2l0tY1VSSgcky7dBCnGazseHlHBZykl7a
	7fmZlB1kgYb3yvDsP0kBOyL58rvEWM7j9A9P+4GN13zbY6uunSeK+Vtgz4wwCF5XgkqIjiWUTqs
	uFdj6ITHf9s3Mul9jBFoITCeSx60D
X-Received: by 2002:a17:907:318b:b0:978:9e92:f903 with SMTP id xe11-20020a170907318b00b009789e92f903mr14185772ejb.46.1687376151208;
        Wed, 21 Jun 2023 12:35:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51NOKM6Hh8QN0QCcGLMN0OqKzbU24DH+VSjfeMgqWRfUYyLOh0do5mrwNmWyPSg9IfSAguew==
X-Received: by 2002:a17:907:318b:b0:978:9e92:f903 with SMTP id xe11-20020a170907318b00b009789e92f903mr14185759ejb.46.1687376150843;
        Wed, 21 Jun 2023 12:35:50 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:35:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230621153237-mutt-send-email-mst@kernel.org>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621152451-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FDB711FBC0528822106FDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FDB711FBC0528822106FDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 21, 2023 at 07:28:33PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 21, 2023 3:26 PM
> > 
> > On Wed, Jun 21, 2023 at 05:52:28PM +0000, Parav Pandit wrote:
> > >
> > > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > > Sent: Wednesday, June 21, 2023 12:46 PM
> > >
> > >
> > > > SET carries an additional 32 bits of information. But if you think
> > > > this will make the overall structure more concise, I'm ok.
> > > >
> > > If it is placed in single structure than it needs to be reworded to remove WO
> > or RO notion.
> > 
> > Not really. all of structure is RO and WO.
> >
> For the device, what is the meaning of driver writing supported_tunnel_types in SET command?
> Ignore? It doesn't make sense to pass something to ignore.

It can be helpful for debugging. E.g. if driver sets
a bit that device does not recognize, it can figure
out that driver has it set in supported mask.
Or if it seems like a waste we can just ask drivers to
put 0 there, works for me too.


> Two structures are cleaner.

Frankly what's cleaner is what RSS is doing, supported mask in config
space. Was this discussed in some version? I don't remember.

> > > This also requires additional sw to indicate dma attributes to be RW when
> > mapping this area.
> > > And extra text to indicate that supported_hash_tunnel_types to be ignored
> > on set command.
> > >
> > > Two structures are more cleaner serving its purpose.
> > 
> > No because all of structure is RO or WO.
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

