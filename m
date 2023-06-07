Return-Path: <virtio-dev-return-12875-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D15C77B7A
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 02:27:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 99372C6230
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 02:27:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 815DB986586
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 02:27:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 64F27986585; Wed,  7 Jun 2023 02:27:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E682986587
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Jun 2023 02:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: J6RMuPv1NByUE4nae7-rbw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686104843; x=1688696843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NggKxic/DJ6+CUoP0PHg/fUiFlkkW+nS92XPKZ0Ep8=;
        b=HCAFgc3IsFPdOFilHM1fsMesocrYMVDMPlF1IHbNJcR82mEaa1rv2r7H22kH0eAj+M
         bwvzQ/r3nTYU5RA9kaqfXlEfmjpFiNznOKzV9kU2ZvD+b2vhhkSWJSQrJqzERaPHYhfv
         KbgEXSCzqQyAUm6M0Es3CoV4kz9BC3XGCwAO1MeXNc+CnGWUwVhE5inBS9u+3SSi/JNj
         tW7mtel7BFi2OpU5CzScQx+rVXL7iJx8sCkVSOxaLPPT4paFtHfB1w6dByQDHf5k+w67
         19VcQ9s0sps2aUOKqdxPklVBjLwdnBsT3SrgB+o2atCtB0DXdKjjX9ziPtjIFyOrBWso
         wtrg==
X-Gm-Message-State: AC+VfDyjsNZXIuGTMDkw+Vf1boC6mRtkgbdi78zPbtLW651KSy4Mn+kf
	oeId7Aqckrql38ThpsLpEthu+eYj5C65JjaauEObblK2FEdnXjt42i0KW1I4AHkJhjDgxUuoWt8
	PomiTOp07k/UQcgMKpI1qB5geDanEKbwkk9v52GByPVvs
X-Received: by 2002:ac2:4858:0:b0:4f6:1bd2:66c3 with SMTP id 24-20020ac24858000000b004f61bd266c3mr1533127lfy.25.1686104843582;
        Tue, 06 Jun 2023 19:27:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6r9AwF8eGZ8W0CYWfjj3dqBY06hTvgLYFbctsCi+8O6JpcTVGJIjDjM1WzjqkXSgGiHde05Mq9NQzhzD8E78s=
X-Received: by 2002:ac2:4858:0:b0:4f6:1bd2:66c3 with SMTP id
 24-20020ac24858000000b004f61bd266c3mr1533117lfy.25.1686104843231; Tue, 06 Jun
 2023 19:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org> <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org> <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230606073544-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Jun 2023 10:27:12 +0800
Message-ID: <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Tue, Jun 6, 2023 at 7:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 05, 2023 at 10:12:59PM +0000, Parav Pandit wrote:
> > Rolling v4 now.
>
> Great thanks! I think the result will be in a good shape from
> the ABI point of view. Good job!
>
> I think so far Jason was the only one with significant comments
> on the series so let's see what he says.

I can't say I like this. I prefer to do meditation on top of a modern
device with some lightweight features like _F_LEAGCY_HEADER. I don't
see any advantages of a new legacy ABI over _F_LEGACY_HEADER. I don't
want to repeat but I don't get any response here

https://lore.kernel.org/virtio-dev/CACGkMEuixsBibSq_pEQvcKOH0WBQWnta4Q2c28S=
V8qTS8gaVcA@mail.gmail.com/#t

>
> From my personal POV what will be left to do to get this
> feature ready for merging would be
>
> - tightening the language:
> - thinking of and addressing all kind of corner cases.

We need first to check whether it's possible (not too late) to find
all the corner cases.

Thanks

>
>
> Since by now from our email discussions I have I think
> a decent understanding of how the feature is supposed to work
> I understand how these things work but I think there are still
> things that would be a bit unclear for an unprepared reader.
>
> Just to give a random example, there's no explicit
> time where the member kind of switches to the legacy/back to modern
> mode. I am guessing setting DRIVER bit through legacy interface
> does this. We'll want to list that.
>
> I'll try to help find these issues and maybe even suggest wording.
>
> I've delayed commenting on these until the high level design is agreed
> on, didn't want to make you waste time on polishing as the patches
> undergo significant changes, and I suggest you do the same in v4: let's
> make sure there's a wide agreement on the ABI then focus on the spec
> language.
>
>
>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

