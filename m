Return-Path: virtio-dev-return-3719-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D5247581904E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Apr 2018 01:04:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403151915-mutt-send-email-mst@kernel.org>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-4-git-send-email-si-wei.liu@oracle.com> <20180403151915-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Wed, 4 Apr 2018 01:03:53 -0700
Message-ID: <CADGSJ20=yqKTAz3wTV=uUH0zohw+a698FVrgaNvmTTK9TMSj_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [RFC PATCH 3/3] virtio_net: make lower netdevs
 for virtio_bypass hidden
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, David Miller <davem@davemloft.net>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 3, 2018 at 5:20 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Apr 01, 2018 at 05:13:10AM -0400, Si-Wei Liu wrote:
>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> index aa40664..0827b7e 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -80,6 +80,8 @@ struct virtio_net_config {
>>       __u16 max_virtqueue_pairs;
>>       /* Default maximum transmit unit advice */
>>       __u16 mtu;
>> +     /* Device at bus:slot.function backed up by virtio_net */
>> +     __u16 bsf2backup;
>>  } __attribute__((packed));
>
> I'm not sure this is a good interface.  This isn't unique even on some
> PCI systems, not to speak of non-PCI ones.

Are you suggesting adding PCI address domain besides to make it
universally unique? And what the non-PCI device you envisioned that
the main target, essetially live migration, can/should cover? Or is
there better option in your mind already?

Thanks,
-Siwei
>
>>  /*
>> --
>> 1.8.3.1
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

