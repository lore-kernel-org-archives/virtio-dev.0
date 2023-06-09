Return-Path: <virtio-dev-return-12918-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC416C7EE25
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 06:27:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 03EA52B02B
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 06:27:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBE2D98669E
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 06:27:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C330298668F; Fri,  9 Jun 2023 06:27:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ACC2E986692
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Jun 2023 06:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: sSN_z2a9P7Kz-2GqWFbrJQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292033; x=1688884033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6OCVawmWS9XtMxbpQr5dKpuPSqV5sPdDOaHG8KO+SQ=;
        b=NSNxINgumE/4bWu8gMjBteMLqBjBbszlMu5pkG5SOlCYzvtCiYibPkJ3FcUdZ8LWrA
         W+kd5B+48Ys450yQhm+XMp0sHHLB1NjVjHGpjj2Jp/OoouCwM8HN75OoFkL33cQHHQXj
         ynQOc7MMw1m64AePVhimbARyuKURRfezV3iMka3R0aj1EcuqpXSL7k9tkHdao5z954+y
         Al3hn4Rq4OgTVdzzJeeiCSBfrwbVbkiRibZAv8j+6i4Qv/J6Z2RYaFPN4apbI6yzXjwX
         AHzmSiDJpRNBCxTNTLxmQ9wI7th/5IFOMz006oDl5BWbotY7EJHbg9No/1W5npi32HX2
         cP7g==
X-Gm-Message-State: AC+VfDxOcF1Mh9+t5KdCksQWxkQP7NtmKPL3XthhSrJJqSgbo77nHftc
	16upveuryU2bQcBqrgWCAtuL0vLsGf4V5bE7Tn+e9Ltda5RCfR9rR/WY9lOjed0bDip8Bech9X5
	i5EdNok4Ad29ppljw29xzPEh8x31StBRbi+crDY85sncz
X-Received: by 2002:a2e:87d6:0:b0:2b1:b4e9:4c3 with SMTP id v22-20020a2e87d6000000b002b1b4e904c3mr495972ljj.2.1686292032795;
        Thu, 08 Jun 2023 23:27:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6myDl6Q+58Pao81Zr8x2W1DrLBgt3RNlCTBK0gxuoJSuqXDAnUglMxxlteokdDbEkEw82gVX+68oF8hVAyVJY=
X-Received: by 2002:a2e:87d6:0:b0:2b1:b4e9:4c3 with SMTP id
 v22-20020a2e87d6000000b002b1b4e904c3mr495956ljj.2.1686292032495; Thu, 08 Jun
 2023 23:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org> <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org> <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org> <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com> <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jun 2023 14:27:01 +0800
Message-ID: <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Fri, Jun 9, 2023 at 11:26=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, June 8, 2023 11:03 PM
>
> > When legacy drivers are doing feature negotiation, the hypervisor must =
trap and
> > negotiate those two features.
> Device reset to be trapped as well towards 1.x.

It needs to be trapped even with admin virtqueue.

>
> And this messes the 1.x flow with FEATURES_OK.

How can it mess? The new status was hidden from the legacy driver.
This kind of trick has been used by Qemu for a while.

> More citations from the spec:
>
> "Legacy driver implementations often used the device before setting the D=
RIVER_OK bit, and sometimes
> even before writing the feature bits to the device."
>
> It may even set before setting the feature bits.

How does adminq differ/help in this case? Note that the legacy
interface is fully mediated/emulated, the control patch is fully
trapped so it can choose to do anything it can.

What's more important, the above example is exactly what we should do
with modern devices since it's too late to precisely define the
behaviour of the legacy device. Admin virtqueue is not the cure for
this since the legacy device's behaviour is defined by the existing
hypervisor codes, not the spec.

So again, we have:

1) well defined (if it's not we can fix the spec) device behaviour
(modern device plus well defined legacy features like mac/header)
2) device with legacy behaviours that can't be defined or documented
(approach used in this series)

1) is far more simple for both hypervisor and hardware and 2) may end
up with subtle undocumented behaviour differences among vendors.

> It is ugly to use the 1.x state machine.

This is the methodology used by mediation which is very common in
virtualization.

> I would like to keep the stateful interactions of 1.x device outside of 0=
.9.5.

I don't think this is a real problem, but let's see the drawbacks of
this proposal:

1) non-trivial changes of full new transport alike ABI
2) can't work for nesting
3) require vendor to implement legacy behaviour which can't be
documented precisely
4) require admin virtqueue to work

We won't have the above issues if we use modern + legacy header/mac.

Thanks


>
> > When modern drivers are doing the feature negotiation, the hypervisor i=
s not
> > involved at all. So modern drivers can choose to negotiate (e.g try to =
mediate
> > legacy for L2) or not.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

