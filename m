Return-Path: <virtio-dev-return-12076-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E5EC77B6E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 02:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E3AC52B014
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 02:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A74AD986371
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 02:05:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8BB9B9843C6; Mon, 10 Apr 2023 02:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A64D986319
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 02:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: R4d7s7mjN6a2TsCRY-tB7g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681092268; x=1683684268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAosJfwM8OyMqKp3bHIBDIIr0N64vi+br5sWsmxNZGg=;
        b=sFgte97LaidDURdU9mamKTBAPwEFIYylhY7EVPkhDUBEli64SdAmS4H2im4LyKkjC5
         PPJBSnYP0RZD70PccSAkdtVU/XPUgQ8kq+zkLAUhpnrO2UwU2UCWHFSJ9lgrMPfbRBhb
         i8x9R8tDdh06/zinX8FI4IkZNMkzCI1Aeji9YDB05EFLrrXKiiYc+9qLREim/a9uUgYo
         RkbHIsWl2j9wR+jL16aLTq6vBofJWISMd9D2DxnTDGEmQiRAuo1y4+KbhP53SzoktHcV
         m71bR6J32DBpIi+0uv1WYWZ8rOxRCo95SonL9gqmUPQgUMZlxfIfeD0v7Ih0RfPHRLkU
         JfTA==
X-Gm-Message-State: AAQBX9eQvz6Uh5JXhF/f2BoI9l+FyS2gmHzuSji/2AaJrxhMS5v+bv9n
	Q3Om7jmDEy0oDogR7y1zPliiRqs7MW1nNKF8pK4rf4llxnCPaT+iqEWIMPIBwM/TIKjFfKmoLZZ
	NHFbo1culOW1V29SHHBrXwyIOtsHaaPHHfEl/f1PeOuM6
X-Received: by 2002:a05:6870:96a3:b0:184:4c39:fe30 with SMTP id o35-20020a05687096a300b001844c39fe30mr762253oaq.9.1681092268325;
        Sun, 09 Apr 2023 19:04:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zj1/wGcqEG4Fv+Zg4VWAptZBbdUhZ+qwAtPPIfi9K8s3K7B8efePimDBJmksi/rQ6V+kBzaXPb7bLhc80e/uc=
X-Received: by 2002:a05:6870:96a3:b0:184:4c39:fe30 with SMTP id
 o35-20020a05687096a300b001844c39fe30mr762237oaq.9.1681092268085; Sun, 09 Apr
 2023 19:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com> <20230323154656.7f036d52.pasic@linux.ibm.com>
 <ff9b28a1-e0ee-f082-1f40-f3e149c9403e@linux.alibaba.com> <7a9ebec0-5e87-b80f-4f2c-c4db7ae4fe84@linux.ibm.com>
 <20230405084632-mutt-send-email-mst@kernel.org> <1680837735.392044-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEv=7FyVZme6HBRxy6U9+7ehiwUTc9=z7PHt6R7ZER7EPg@mail.gmail.com> <1681091624.0967045-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681091624.0967045-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 10:04:17 +0800
Message-ID: <CACGkMEtOpa3Oqhp2VrVKGXEhM9irVHbzE8DUEa1xCn+7W2ssdg@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Halil Pasic <pasic@linux.ibm.com>, virtio-comment@lists.oasis-open.org, 
	hans@linux.alibaba.com, herongguang@linux.alibaba.com, 
	zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, 
	zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, 
	gerry@linux.alibaba.com, cohuck@redhat.com, 
	Jan Kiszka <jan.kiszka@siemens.com>, kgraul@linux.ibm.com, wenjia@linux.ibm.com, 
	jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, 
	raspl@linux.ibm.com, virtio-dev@lists.oasis-open.org, 
	Alexandra Winter <wintera@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v3
 1/1] virtio-ism: introduce new device virtio-ism

On Mon, Apr 10, 2023 at 10:01=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Mon, 10 Apr 2023 09:23:04 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Apr 7, 2023 at 11:24=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 5 Apr 2023 08:52:14 -0400, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > On Wed, Apr 05, 2023 at 02:39:53PM +0200, Alexandra Winter wrote:
> > > > >
> > > > >
> > > > > On 24.03.23 05:03, Wen Gu wrote:
> > > > > >
> > > > > >
> > > > > > On 2023/3/23 22:46, Halil Pasic wrote:
> > > > > >
> > > > > >> On Thu,  9 Feb 2023 11:30:56 +0800
> > > > > >> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >>
> > > > >
> > > > > ...
> > > > >
> > > > > >
> > > > > >> To get back to the things proposed here: the cdid is IMHO
> > > > > >> a nice thing, and is functionally corresponding to the
> > > > > >> (S)EID. But it is 16 byte wide, and I have no idea how
> > > > > >> is it supposed to be used in the CLC handshake.
> > > > > >>
> > > > > >
> > > > > > CLC handshake carry one SEID for all the SMC-D device. Consider=
ing
> > > > > > coexistence with ISM, I am not sure whether we can change or in=
crease
> > > > > > the SEID.. cc Alexandra
> > > > > >
> > > > > > Thanks!
> > > > > > Wen Gu
> > > > >
> > > > > As mentioned by others, discussions are ongoing.
> > > > > It would be great, if we can agree on a way to use the existing C=
LC handshake
> > > > > for SMC-D via virtio-ism and ism-loopback.
> > > > > In that case SEID needs to be unique per hardware instance, canno=
t be increased and
> > > > > can only be changed for x86 in a non-colliding way.
> > > > >
> > > > > An alternative would be to define new a SMC-D(?) protocol variant=
/version, where we
> > > > > are free to define new fields (e.g. UUIDs).
> > > > >
> > > > > Alexandra
> > > >
> > > > Problem with tying to hardware is that it is blocking
> > > > migration (which is a challenge with ism anyway, but still).
> > >
> > >
> > > We don't want to support migration. At least we don't want to support=
 it for the
> > > time being. Because there are indeed many problems. I think Migration=
 is not
> > > necessary for a new Virtio device.
> >
> > We'd really need to take migration into consideration when developing
> > new devices. It is not guaranteed that this device is backed by local
> > RAMs.
>
> Yes, we have some considerations and researches on the aspects also, such=
 as
> CXL.
>
> We have not planned introducing these in SPEC directly, because we dont e=
ven
> have a POC. It's just that there are researches in this area and we haven=
't
> actually operated it.

Good to know that.

>
> > At least we should avoid designs that may complicate future
> > migration support.
>
> Yes, we try to avoid it. If you find that we have this problem, you are w=
elcome
> to point out.

That's fine, this device is really interesting (but I haven't had time
in going though this again).

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > > >
> > > > > >> If this is really supposed to work with SMC and not just take
> > > > > >> inspiration from it, I would like some insight from our
> > > > > >> SMC experts (they are already on copy).
> > > > > >>
> > > > > >> Regards,
> > > > > >> Halil
> > > > > >>
> > > > > >> --------------------------------------------------------------=
-------
> > > > > >> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-ope=
n.org
> > > > > >> For additional commands, e-mail: virtio-dev-help@lists.oasis-o=
pen.org
> > > >
> > > >
> > > > -------------------------------------------------------------------=
--
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
> > > >
> > >
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > >
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > >
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license=
.pdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/maili=
ng-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

