Return-Path: <pasic@linux.ibm.com>
Date: Tue, 5 Oct 2021 13:17:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
Message-ID: <20211005131751.53175b10.pasic@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 4 Oct 2021 16:01:12 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > 
> > Ok, so what about something like
> > 
> > "If FEATURES_OK is not set, the driver MAY change the set of features it
> > accepts."
> > 
> > in the device initialization section?  
> 
> Maybe "as long as". However Halil implied that some features are not
> turned off properly if that happens. Halil could you pls provide
> some examples?



static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
{
...
    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
        qapi_event_send_failover_negotiated(n->netclient_name);
        qatomic_set(&n->failover_primary_hidden, false);
        failover_add_primary(n, &err);
        if (err) {
            warn_report_err(err);
        }
    }
}

This is probably the only one in QEMU. Back then I stopped looking
after the first hit.

Regards,
Halil

