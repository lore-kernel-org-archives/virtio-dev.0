Return-Path: <virtio-dev-return-8783-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14AA19863BB
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Oct 2021 15:20:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211005072110-mutt-send-email-mst@kernel.org>
References: <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
 <20211004160005-mutt-send-email-mst@kernel.org>
 <20211005131751.53175b10.pasic@linux.ibm.com>
 <20211005072110-mutt-send-email-mst@kernel.org>
Date: Tue, 05 Oct 2021 17:20:29 +0200
Message-ID: <87fstf1osi.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 05 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 05, 2021 at 01:17:51PM +0200, Halil Pasic wrote:
>> On Mon, 4 Oct 2021 16:01:12 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > > 
>> > > Ok, so what about something like
>> > > 
>> > > "If FEATURES_OK is not set, the driver MAY change the set of features it
>> > > accepts."
>> > > 
>> > > in the device initialization section?  
>> > 
>> > Maybe "as long as". However Halil implied that some features are not
>> > turned off properly if that happens. Halil could you pls provide
>> > some examples?
>> 
>> 
>> 
>> static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>> {
>> ...
>>     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
>>         qapi_event_send_failover_negotiated(n->netclient_name);
>>         qatomic_set(&n->failover_primary_hidden, false);
>>         failover_add_primary(n, &err);
>>         if (err) {
>>             warn_report_err(err);
>>         }
>>     }
>> }
>> 
>> This is probably the only one in QEMU. Back then I stopped looking
>> after the first hit.

After some grepping, I agree that this seems to be the only one.

>> 
>> Regards,
>> Halil
>
> Hmm ok more failover issues :(
> This stuff really should be moved to set_status.

Yes, F_STANDBY does not exist for legacy, so performing those actions
when FEATURES_OK is set looks like the right thing to do.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

