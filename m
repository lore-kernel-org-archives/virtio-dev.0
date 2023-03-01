Return-Path: <virtio-dev-return-11349-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703EBC6FA9D
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:37:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BD7DC7C3AC
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:37:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEA5098667C
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:37:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A3C8F98666C; Wed,  1 Mar 2023 17:37:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93B1998666F
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Mar 2023 17:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: boMCpqj1MlOLVQFzl67CyQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677692255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp9vtpPtzLgqZ0xHLPWJJ4YuVwUEHpozwjCDA2qsRQs=;
        b=JP4VzeSJp5R/xNdUWd7FT9vPCHMK2YpUDx57FbpQpd+Y44wRbcussnCRLADd3ko2Ew
         00gP8/xAqxgPsRRD9H1zhMZhGcreHUh55nSRzatSsROQFXr9nkfcaJnb05UGe0q+tZe5
         VeDoNNsRk7QZu26P8w8THtBht/yt/TJSJ/fXj0FE3ZdNU9FQi/HVkK3Wi1Xw9zzLtg82
         vAvxm74Nun/oDXbUOpkYxn+OLXDKtu+RsKUGYShVyYmDd9Dby+cXniZTWMyq2OwvZP6Z
         Z/bnaeY2dnbGtx70d9E+E+ez6QbLecD12OE2IUVQB+q/NUCBNuObxJWJB1/Ze4MieKAU
         FTMg==
X-Gm-Message-State: AO0yUKVDfXfa1QQYbqPB7H0hp8aHOAZp6vu4477/XMWsYauHbrEO/5ha
	D4eiSF52/AYb41Y7B/nxvAEMPJlnZqB1rhArFNx08svhOr5qz5rUsmPoPWNMEJ3uKdlGRClXBCE
	+/63w2LSSFlRb1t/ZPxl+rOQcBN7FSkYEbA==
X-Received: by 2002:a05:6000:1b8f:b0:2cb:72c2:3d12 with SMTP id r15-20020a0560001b8f00b002cb72c23d12mr5412738wru.68.1677692254932;
        Wed, 01 Mar 2023 09:37:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+r7BPp3GGxhvEWkteRL/78JO7rLsmw9gHvEDkQvn0ZzWpB5OZt0yDbEeFM2flEN2mfvSiW7w==
X-Received: by 2002:a05:6000:1b8f:b0:2cb:72c2:3d12 with SMTP id r15-20020a0560001b8f00b002cb72c23d12mr5412722wru.68.1677692254641;
        Wed, 01 Mar 2023 09:37:34 -0800 (PST)
Date: Wed, 1 Mar 2023 12:37:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
	virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230301123044-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com>
 <20230301182207.23f995cd.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230301182207.23f995cd.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Wed, Mar 01, 2023 at 06:22:07PM +0100, Halil Pasic wrote:
> On Mon, 27 Feb 2023 09:45:31 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > For the vq index/number, I'm not that sure that "virtqueue number" is
> > better that "virtqueue index" -- actually, I'd prefer the latter. We'd
> > need some renaming either way.
> 
> I prefer index as well. Especially that we start indexing with 0. Also
> seems to be the more common term for such stuff in both Mathematics and
> CS.
> 
> Regards,
> Halil 


Basically I am saying that this:

/* Queue size for the currently selected queue - Write Only */
#define VIRTIO_MMIO_QUEUE_NUM           0x038

is a bad name because queue number seems to be ambiguous.

Maybe start with just getting rid of uses of QUEUE_NUM meaning size?


If we want to use queue index we need to fix RSS spec in networking
since that seems to want to use queue index in a very weird way:
networking has this idea of calling queues like this:
receiveq1 receiveq2 ....
why 1-based? I guess we wanted this to be clear even to a 5 year olds ;)

And then for extra fun, in the RSS section we say "0 based index" where we
seem to mean "this number in the queue name, but subtract 1 in your head".
Why subtract 1? I guess we wanted these 5 year olds to practice math ...


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

