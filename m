Return-Path: <virtio-dev-return-14351-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF8C47DD9
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 02:43:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F5502AF8D
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 02:43:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F14B986339
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 02:43:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8229E9841A0; Mon, 26 Feb 2024 02:43:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72BBD98632B
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Feb 2024 02:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708915398; x=1709520198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXUn5gTU1kYEBS6NhFbLUDgmoZ07scj8rBDs75VEjTw=;
        b=Smh6fysyHqz1ITF+jZnFpxqVXCdKfgpbcW65USmhaGtc3HRDw78MYCVx8XXnR0SlUu
         GZ+m4AOrCaFonZwvek/8VxbOgGXWR/zAsBeak42BH6QVbh2NcxkKeXeMcoKG7gHVUCVB
         yesbaRB6DfPzJW7iAzbHLPJmRi4p7fLWRrkJDAk8emeD/haAr0I79mUeU+CbzXtqbUR7
         SCdsc4i9lnVudCXHFOQ/cqzbk3vk7OuoyNX8spllKfaBd3VTfI7xkA4sD+w7he+UKzTt
         9udk5m6vmreubYkjHccElkJH+frtBkh7ndLoxYVWY7qFiZ2i9PCqYEo1KahUZFTEFk+7
         SS8g==
X-Forwarded-Encrypted: i=1; AJvYcCWPNSDApm9VTukP7CLIth7B0en6sZvf+7OSc7dZ1df24thcSU+I6wjh+qeDPm2E5oOhefBtcKg+4kROjV0awL6wo5i6kRU+8uG1wbfLabo1
X-Gm-Message-State: AOJu0Yx8P8MOMZWc8jEkggULtaooKXno02pNOaGSVyIoKay5yoqIf2Uw
	wfav3pZsa2JvbenHpXac9DPywQKC3MRU3cRkpoVi0rm/aTQ6S/K7w2GfX73l0cU4Ov4zP3cKK6b
	beHLmEIHyYafqHoMxGZeqC3ZJ2ziX9+ABtJQj
X-Google-Smtp-Source: AGHT+IG0PVW7R1GHDJDJUKrnjtrF35757OgcH8a89DyPeTuGplg5opBDDPshm9s8Uzbs47jfmymqcm95vMUB6SknnKI=
X-Received: by 2002:a05:6512:2826:b0:512:eb44:1ea1 with SMTP id
 cf38-20020a056512282600b00512eb441ea1mr1852029lfb.21.1708915398329; Sun, 25
 Feb 2024 18:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20240218132306.83456-1-lingshan.zhu@intel.com>
 <20240218090935-mutt-send-email-mst@kernel.org> <CAD=HUj4b3gLsA2VD4cxmVzLPGRZfaREQcJNb4zfxLH=xv=2X6g@mail.gmail.com>
 <be09ad18-398e-47c0-abea-3f025df40734@intel.com> <CAD=HUj6iVc=QpA6kGyNhdM-BrD5tuAj1yUkS6gJtU+hi=QmtLg@mail.gmail.com>
 <70693394-289e-42d0-a6da-b41bfab28c44@intel.com> <20240225034902-mutt-send-email-mst@kernel.org>
 <ac18a34e-6d8c-45a3-8c2f-65df0829a60f@intel.com>
In-Reply-To: <ac18a34e-6d8c-45a3-8c2f-65df0829a60f@intel.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 26 Feb 2024 11:43:07 +0900
Message-ID: <CAD=HUj40DFWr=oVZNsO=342xgv0n45SxYx8ex+QwhNq592yfVQ@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, eperezma@redhat.com, 
	cohuck@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio: introduce SUSPEND bit in device status

On Mon, Feb 26, 2024 at 10:36=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@intel.=
com> wrote:
> On 2/25/2024 4:52 PM, Michael S. Tsirkin wrote:
> > On Fri, Feb 23, 2024 at 03:44:41PM +0800, Zhu, Lingshan wrote:
> >>
> >> On 2/20/2024 1:09 PM, David Stevens wrote:
> >>> On Tue, Feb 20, 2024 at 1:06=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@i=
ntel.com> wrote:
> >>>> On 2/19/2024 2:46 PM, David Stevens wrote:
> >>>>> On Sun, Feb 18, 2024 at 11:11=E2=80=AFPM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> >>>>>> On Sun, Feb 18, 2024 at 09:23:06PM +0800, Zhu Lingshan wrote:
> >>>>>>> This commit allows the driver to suspend the device by
> >>>>>>> introducing a new status bit SUSPEND in device_status.
> >>>>>>>
> >>>>>>> This commit also introduce a new feature bit VIRTIO_F_SUSPEND
> >>>>>>> which indicating whether the device support SUSPEND.
> >>>>>>>
> >>>>>>> This SUSPEND bit is transport-independent.
> >>>>>>>
> >>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>>> Could we get some kind of dscription how this has taken into
> >>>>>> consideration the proposal from David Stevens?
> >>>>>>
> >>>>>> I find it really tiring when there are competing patches with auth=
ors
> >>>>>> ignoring each other's work and leaving it up to reviewers to
> >>>>>> figure out how do the patches compare.
> >>>>> This patch looks like it could be used to implement my use case.
> >>>>> However, parts of it are a bit vague and imprecise, so it's hard to
> >>>>> actually say whether my use case would actually be covered by a
> >>>>> specific implementation of this proposal.
> >>>> I am on vacation till this Friday. Shall we co-work on this and
> >>>> post something new together?
> >>> That works for me.
> >> Cool! How about two patches in a new series:
> >> 1) a general virtio suspending patch describing suspending behaviors f=
or all
> >> virtio devices from me, an updating version of this patch
> >> 2) a PCI transport suspending patch from you, describing PCI specific
> >> behaviors.
> >>
> >> Dose this sound good to you?
> > Well David's patch was more precise than yours, and also better worded.
> > So think if there's an agreement you guys would really start with that,
> > move the functionality to the status bit and make other changes as need=
ed.
> I think we plan to cooperate on a new series including both the status
> bit and
> PCI transport, collaborations on both of our patches.
>
> Let's see whether this looks good to David

That works for me. I can incorporate the feedback on both proposals
and send out a combined version in the next day or so.

Thanks,
David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

