Return-Path: <virtio-dev-return-12760-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE32C77B7A
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:06:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F14902B07B
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:06:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4508986730
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:06:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D7CF59841AB; Fri, 19 May 2023 06:06:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC768986722
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 May 2023 06:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: CgwMNHu2PHi6gmg2tMn5Mw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684476406; x=1687068406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEv0PjBkLn4zVpTZo646FhdXsMPioqmT9MgIbE6KM54=;
        b=dcgfuwI6FBKrPsIASf6zgpZaQHTkmVH3Dw0z1N0E8mncTmx2QiGu85uQy9vrpz23Yg
         r23jfhjE9vkgV2Tn1siSrpAcV4Dx5kVlhcg4ebGSSguqk0o7B2OwSQNMskZ7pOx62POJ
         880Yh4mSocWhHBMmhloVKZx4cn/jjdI3dxiVFYIzTLizyGT4km2XeA1H8g/mFodMqGA0
         OaZOOldT/rCfcNafJTViBeo85OcuzDaoVhfQpkHOykf2raV9Q5uaV30DRRal1919EofL
         pfcbfJSysqpisPaMGIgw6IAnsPi9sOvuRM75rNrK8d0xhutbgX2rf3Ht/70qqAleRqgo
         HEIg==
X-Gm-Message-State: AC+VfDxJzPhe0JYgh5EHbnBja32Enrq+N5zhasK3VAiYJSPn9qJKvpz6
	EsbwBSOiJ0zpZkGB/tXrAKDcJgLLe3g55wTIIziM0LQOUQfcR1S+LfjUV+1yGFDpOOZehetGoL/
	eXVmELNble+qC8XaJLyytIE/goicI
X-Received: by 2002:a19:550b:0:b0:4f3:ab2a:50f9 with SMTP id n11-20020a19550b000000b004f3ab2a50f9mr450668lfe.56.1684476406114;
        Thu, 18 May 2023 23:06:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QfxoGJ6Dh/bqnn9UwoNbb4xjXDy8Xh/OMibF1DwHNz69H7wTgKu4bL1pv9LCn4BZEKnX42Q==
X-Received: by 2002:a19:550b:0:b0:4f3:ab2a:50f9 with SMTP id n11-20020a19550b000000b004f3ab2a50f9mr450653lfe.56.1684476405804;
        Thu, 18 May 2023 23:06:45 -0700 (PDT)
Date: Fri, 19 May 2023 02:06:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230519015520-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230518153640-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Thu, May 18, 2023 at 03:42:19PM -0400, Michael S. Tsirkin wrote:
> > > Does this sound like a reasonable
> > > compromize to you?
> > 
> > Splitting proposed one command to two commands,
> > 1. one for accessing legacy common config
> > 2. second for accessing legacy device specific config 
> > 
> > seems fine to me as below.
> > 
> > So we will have total 5 commands (instead of 3).
> > 
> > 1. legacy common config read
> > 2. legacy common config write
> > 
> > 3. legacy device config read
> > 4. legacy device config write
> > 5. query device notification area
> > 
> > #1 and #3 same cmd signature but different opcode.
> > #2 and #4 same cmd signature but different opcode.
> > 
> 
> Sounds reasonable. Jason?
> 
> notification thing needs more thought I feel though.
> It feels weirdly bolted on, but I can't put my finger
> on what's wrong exactly yet. Will think it over.


So with a fresh mind, at least three things:

1. given driver attaches to the PF, it should be possible to forward
   notifications there, as opposed to individual VFs.  NumVFs is 16 bit so
   it will fit in a 32 bit write together with VQ index.

2. It should be possible to send notifications through an admin command too,
   otherwise admin commands are an incomplete set of functionality.
   
3. I feel using a capability to describe legacy notification
   area would be better just because we already have a
   structure for this. make it an express capability if you like.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

