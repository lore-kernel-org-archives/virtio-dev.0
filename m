Return-Path: <virtio-dev-return-8779-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1ACB4986390
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Oct 2021 07:38:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211004160005-mutt-send-email-mst@kernel.org>
References: <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
 <20211004160005-mutt-send-email-mst@kernel.org>
Date: Tue, 05 Oct 2021 09:38:05 +0200
Message-ID: <87r1cz2a76.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 05:45:06PM +0200, Cornelia Huck wrote:
>> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
>> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > Do we want to also add explanation that features can be
>> >> > changed until FEATURES_OK?
>> >> 
>> >> I always considered that to be implict, as feature negotiation is not
>> >> over until we have FEATURES_OK. Not sure whether we need an extra note.
>> >
>> > Well Halil here says once you set a feature bit you can't clear it.
>> > So maybe not ...
>> 
>> Ok, so what about something like
>> 
>> "If FEATURES_OK is not set, the driver MAY change the set of features it
>> accepts."
>> 
>> in the device initialization section?
>
> Maybe "as long as". However Halil implied that some features are not
> turned off properly if that happens. Halil could you pls provide
> some examples?

Yes, "as long as" sounds better.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

