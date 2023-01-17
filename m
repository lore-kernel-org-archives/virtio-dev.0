Return-Path: <virtio-comment-return-3855-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com> <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 17 Jan 2023 14:44:42 +0200
Message-ID: <CAJs=3_CQLqOC=KQ_-Syw6mWM0_SuehE_J9N8oexGihVA8dCBDQ@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v2] virtio_net: support low and high rate of
 notification coalescing
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

> > This patch adds a new feature, VIRTIO_NET_F_NOTF_COAL_LOW_HIGH, while
> > clarifying/fixing existing coalescing concepts.
> >
> While its visible in the patch itself, what is being done,
> its important to mention the problem statement/motivation for the feature at start of the commit log as first step.
>
> So, can you please describe the motivation, what problem does the new command solve?
> It is likely that control entity which want to set different coalescing parameters likely wants to more than just two values.
> This is something already supported today.

I'll add a better commit log in the next version.

> > On top of the new feature, this patch:
> >       - Unifies the virtio_net_ctrl_coal structs, since the one for tx
> >         and the one for rx are identical.
> >       - Clarifies that the coalescing commands are best-effort.
> >       - Specifies coalescing in respect to delivering interrupts when config
> >           changes.
> >
> They are best to be handled a pre-patch to this one.
> Please split them so that spec improvement work can progress while new features are under review.

ok

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

