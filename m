Return-Path: <virtio-dev-return-12217-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439D6C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 02:37:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 556872AD78
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 02:37:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36D26986617
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 02:37:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1A3A3983C98; Fri, 14 Apr 2023 02:37:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02C15986601
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 02:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JiCAx5Y1N5S0iqZaMgUJ1A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681439824; x=1684031824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDmsQShjzIeD0WvnjZ0qCqGkYB7vmZZCcmJVfFBzqrQ=;
        b=PxOgdpG/9ig8TaQb4VgChMR1d+50bBw5sk2q0bO296puIWcGqy4qPGBpaiiGajMk83
         mvzHkZ4lRny3T9jblK+8pawFm33ED/5N1XvEt9N5sIU+T9niEyoNbFsbbJTO8DDL6LWH
         tEAsmKIQEO3vt8XXKeEIvjvloMyaET7dmb49mB4WG9uh5DQA31f9XWCkRHx+9tvEkYuB
         H4H3Yy96DcCLwaRUtjJ3jyg1TaMgM6A+MV5uRB7n70sbqPG8XIre3ksTjL0/w1yTM9rW
         9wQwhu2ftXd+LJoC1NnaeThZxQI14F6enBJJVzE1OEPN7YG+0FXxK+Vr4lk6u4QwxZA4
         Ji8A==
X-Gm-Message-State: AAQBX9fZPyYnFWd62xOMT9EsLuvd4o1xkJayPNrV3j3lF9u+4q5dKCZV
	1qfMaRwzpM5cwsQ17GPk2rwZMPX2C1UY78aKfGTWU5ynjWL5BnTqtFlxIRhcbroQLUXy9r6sT1S
	GiHPoG3bM1QONhYDFQ/d1kIEC5h3d6G+P4go04Rx7pIqS
X-Received: by 2002:aca:120c:0:b0:383:fad3:d19 with SMTP id 12-20020aca120c000000b00383fad30d19mr953761ois.9.1681439823815;
        Thu, 13 Apr 2023 19:37:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350afP3G19ju5SPTkoh31CFylPIeHGNCR2P5ZN0qWtk7IR61BE+NqLpbEOXR2Yr9ND+LK51ypGpQYmJsiIYaRu/0=
X-Received: by 2002:aca:120c:0:b0:383:fad3:d19 with SMTP id
 12-20020aca120c000000b00383fad30d19mr953752ois.9.1681439823610; Thu, 13 Apr
 2023 19:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com> <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com> <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 10:36:52 +0800
Message-ID: <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Fri, Apr 14, 2023 at 5:08=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, April 13, 2023 5:02 PM
>
> > This thing ... you move some code to the card and reduce the amount of =
virtio
> > knowledge in software but do not eliminate it completely.
> Sure. Practically there is no knowledge other than transporting like a vx=
lan encapsulating, here its AQ.
>
> > Seems kind of pointless. Minimal hardware changes make more sense to me=
, I'd
> > say. Talking about that, what is a minimal hardware change to allow a v=
dpa
> > based solution?
> > I think that's VIRTIO_NET_F_LEGACY_HEADER, right?

I think it is. It would be much easier if we do this.

>
> The main requirement/point is that there is virito PCI VF that to be mapp=
ed to the guest VM.
> Hence, there is no vdpa type of hypervisor layer exists in this use case.

It's about mediation which is a must for things like legacy. If
there's a way that helps the vendor to get rid of the tricky legacy
completely, then why not?

>
> This same VF need to be transitional as the guest kernel may not be known=
.
> hence sometimes vdpa sometime regular 1.x VF is not an option.
> Hence for next few years, transitional VF will be plugged in into the gue=
st VM when user is using the PCI VF devices.

I'm not sure I get this. With VIRTIO_NET_F_LEGACY_HEADER, we don't
need mediation for datapath. For the control path, mediation is a must
for legacy and it's very easy to keep it work for modern, what's wrong
with that?

Thanks

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
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

