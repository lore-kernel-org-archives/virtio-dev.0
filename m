Return-Path: <virtio-dev-return-10114-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36D9398661C
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Nov 2022 12:26:45 +0000 (UTC)
Message-ID: <8bd1dc3b-e1f0-e7f9-bf65-8d243c65adb5@opensynergy.com>
Date: Thu, 3 Nov 2022 13:26:35 +0100
From: Harald Mommer <hmo@opensynergy.com>
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <CAK8P3a1biW1qygRS8Mf0F5n8e6044+W-5v+Gnv+gh+Cyzj-Vjg@mail.gmail.com>
In-Reply-To: <CAK8P3a1biW1qygRS8Mf0F5n8e6044+W-5v+Gnv+gh+Cyzj-Vjg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC PATCH 1/1] can: virtio: Initial virtio CAN
 driver.
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@kernel.org>, Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

currently in the preparation that changed code can go out to the list.

On 25.08.22 20:21, Arnd Bergmann wrote:

>
>>   drivers/net/can/Kconfig                 |    1 +
>>   drivers/net/can/Makefile                |    1 +
>>   drivers/net/can/virtio_can/Kconfig      |   12 +
>>   drivers/net/can/virtio_can/Makefile     |    5 +
>>   drivers/net/can/virtio_can/virtio_can.c | 1176 +++++++++++++++++++++++
>>   include/uapi/linux/virtio_can.h         |   69 ++
> Since the driver is just one file, you probably don't need the subdirecto=
ry.
Easy to do, makes the changes smaller.
>> +struct virtio_can_tx {
>> +       struct list_head list;
>> +       int prio; /* Currently always 0 "normal priority" */
>> +       int putidx;
>> +       struct virtio_can_tx_out tx_out;
>> +       struct virtio_can_tx_in tx_in;
>> +};
> Having a linked list of these appears to add a little extra complexity.
> If they are always processed in sequence, using an array would be
> much simpler, as you just need to remember the index.

The messages are not necessarily processed in sequence by the CAN stack.=20
CAN is priority based. The lower the CAN ID the higher the priority. So=20
a message with CAN ID 0x100 can surpass a message with ID 0x123 if the=20
hardware is not just simple basic CAN controller using a single TX=20
mailbox with a FIFO queue on top of it.

Thinking about this the code becomes more complex with the array. What I=20
get from the device when the message has been processed is a pointer to=20
the processed message by virtqueue_get_buf(). I can then simply do a=20
list_del(), free the message and done.

>> +#ifdef DEBUG
>> +static void __attribute__((unused))
>> +virtio_can_hexdump(const void *data, size_t length, size_t base)
>> +{
>> +#define VIRTIO_CAN_MAX_BYTES_PER_LINE 16u
> This seems to duplicate print_hex_dump(), maybe just use that?
Checked where it's still used. The code is not disabled by #ifdef DEBUG=20
but simply commented out. Under this circumstances it's for now best to=20
simply remove the code now and also the commented out places where is=20
was used at some time in the past.
>> +
>> +       while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
>> +               cpu_relax();
>> +
>> +       mutex_unlock(&priv->ctrl_lock);
> A busy loop is probably not what you want here. Maybe just
> wait_for_completion() until the callback happens?

Was done in the same way as elsewhere=20
(virtio_console.c/__send_control_msg() &=20
virtio_net.c/virtnet_send_command()). Yes, wait_for_completion() is=20
better, this avoids polling.

>> +       /* Push loopback echo. Will be looped back on TX interrupt/TX NA=
PI */
>> +       can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);
>> +
>> +       err =3D virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMI=
C);
>> +       if (err !=3D 0) {
>> +               list_del(&can_tx_msg->list);
>> +               virtio_can_free_tx_idx(priv, can_tx_msg->prio,
>> +                                      can_tx_msg->putidx);
>> +               netif_stop_queue(dev);
>> +               spin_unlock_irqrestore(&priv->tx_lock, flags);
>> +               kfree(can_tx_msg);
>> +               if (err =3D=3D -ENOSPC)
>> +                       netdev_info(dev, "TX: Stop queue, no space left\=
n");
>> +               else
>> +                       netdev_warn(dev, "TX: Stop queue, reason =3D %d\=
n", err);
>> +               return NETDEV_TX_BUSY;
>> +       }
>> +
>> +       if (!virtqueue_kick(vq))
>> +               netdev_err(dev, "%s(): Kick failed\n", __func__);
>> +
>> +       spin_unlock_irqrestore(&priv->tx_lock, flags);
> There should not be a need for a spinlock or disabling interrupts
> in the xmit function. What exactly are you protecting against here?

I'm using 2 NAPIs, one for TX and one for RX. The RX NAPI just receives=20
RX messages and is of no interest here. The TX NAPI handles the TX=20
messages which have been processed by the virtio CAN device in=20
virtio_can_read_tx_queue(). If this was done without the TX NAPI this=20
would have been done by the TX interrupt directly, no difference.

In virtio_can_start_xmit()

* Reserve putidx - done by an own mechanism using list operations in=20
tx_putidx_list

Could be that it's simpler to use idr_alloc() and friends getting those=20
numbers to get rid of this own mechanism, not sure yet. But this needs a=20
locks as it's based on a linked list and the list operation has to be=20
protected.

* Add the TX message to the pending list

Again a list operation which has to be protected.

* Try to send the message

Now it may happen that at the same time while we do something with the=20
lists in virtio_can_start_xmit() the function virtio_can_read_tx_queue()=20
is active accessing the same queue. Comment above virtqueue_add_sgs():=20
"Caller must ensure that we don't call this with other virtqueue=20
operations at the same time (except when noted)."

Also tried, virtqueue_add_sgs() needs this lock.

* And then there is also a list operation on failure of the function

But the code needed to reworked to understand the necessity of each lock=20
again.

> As a further optimization, you may want to use the xmit_more()
> function, as the virtqueue kick is fairly expensive and can be
> batched here.
Looked elsewhere how it works and did.
>> +       kfree(can_tx_msg);
>> +
>> +       /* Flow control */
>> +       if (netif_queue_stopped(dev)) {
>> +               netdev_info(dev, "TX ACK: Wake up stopped queue\n");
>> +               netif_wake_queue(dev);
>> +       }
> You may want to add netdev_sent_queue()/netdev_completed_queue()
> based BQL flow control here as well, so you don't have to rely on the
> queue filling up completely.
Not addressed, not yet completely understood.
>> +static int virtio_can_probe(struct virtio_device *vdev)
>> +{
>> +       struct net_device *dev;
>> +       struct virtio_can_priv *priv;
>> +       int err;
>> +       unsigned int echo_skb_max;
>> +       unsigned int idx;
>> +       u16 lo_tx =3D VIRTIO_CAN_ECHO_SKB_MAX;
>> +
>> +       BUG_ON(!vdev);
> Not a useful debug check, just remove the BUG_ON(!vdev), here and elsewhe=
re
A lot of BUG_ON() were removed when not considered useful, some were=20
reworked to contain better error handling code when this was possible,=20
others were kept to ease further development. If anyone catches=20
something would be seriously broken and had to be fixed in the code. But=20
this then we want to know.
>> +
>> +       echo_skb_max =3D lo_tx;
>> +       dev =3D alloc_candev(sizeof(struct virtio_can_priv), echo_skb_ma=
x);
>> +       if (!dev)
>> +               return -ENOMEM;
>> +
>> +       priv =3D netdev_priv(dev);
>> +
>> +       dev_info(&vdev->dev, "echo_skb_max =3D %u\n", priv->can.echo_skb=
_max);
> Also remove the prints, I assume this is left over from
> initial debugging.
Yes, this thing was overall too noisy.
>> +
>> +       register_virtio_can_dev(dev);
>> +
>> +       /* Initialize virtqueues */
>> +       err =3D virtio_can_find_vqs(priv);
>> +       if (err !=3D 0)
>> +               goto on_failure;
> Should the register_virtio_can_dev() be done here? I would expect this to=
 be
> the last thing after setting up the queues.
Doing so makes the code somewhat simpler and shorter =3D better.
>> +static struct virtio_driver virtio_can_driver =3D {
>> +       .feature_table =3D features,
>> +       .feature_table_size =3D ARRAY_SIZE(features),
>> +       .feature_table_legacy =3D NULL,
>> +       .feature_table_size_legacy =3D 0u,
>> +       .driver.name =3D  KBUILD_MODNAME,
>> +       .driver.owner =3D THIS_MODULE,
>> +       .id_table =3D     virtio_can_id_table,
>> +       .validate =3D     virtio_can_validate,
>> +       .probe =3D        virtio_can_probe,
>> +       .remove =3D       virtio_can_remove,
>> +       .config_changed =3D NULL,
>> +#ifdef CONFIG_PM_SLEEP
>> +       .freeze =3D       virtio_can_freeze,
>> +       .restore =3D      virtio_can_restore,
>> +#endif
> You can remove the #ifdef here and above, and replace that with the
> pm_sleep_ptr() macro in the assignment.

This pm_sleep_ptr(_ptr) macro returns either the argument when=20
CONFIG_PM_SLEEP is defined or NULL. But in struct virtio_driver there is

#ifdef CONFIG_PM =C2=A0 int(*freeze) ...; =C2=A0 int(*restore) ...; #endif

so without CONFIG_PM there are no freeze and restore structure members.

So

 =C2=A0 .freeze =3D pm_sleep_ptr(virtio_can_freeze)

won't work.

>> diff --git a/include/uapi/linux/virtio_can.h b/include/uapi/linux/virtio=
_can.h
>> new file mode 100644
>> index 000000000000..0ca75c7a98ee
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_can.h
>> @@ -0,0 +1,69 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause */
>> +/*
>> + * Copyright (C) 2021 OpenSynergy GmbH
>> + */
>> +#ifndef _LINUX_VIRTIO_VIRTIO_CAN_H
>> +#define _LINUX_VIRTIO_VIRTIO_CAN_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/virtio_types.h>
>> +#include <linux/virtio_ids.h>
>> +#include <linux/virtio_config.h>
> Maybe a link to the specification here? I assume the definitions in this =
file
> are all lifted from that document, rather than specific to the driver, ri=
ght?
>
>           Arnd

The driver as made in parallel to the specification work. So there is no=20
finished specification yet. To avoid traffic (mistake here) I've not=20
sent the patch to the specification to all mailing lists.

Patch to the virtio specification is now here:

https://lore.kernel.org/all/20220825133410.18367-1-harald.mommer@opensynerg=
y.com/

This was made on top of https://github.com/oasis-tcs/virtio-spec.git=20
commit 26ed30ccb049

Harald

As mentioned, the updated code will be sent out to the list(s) soon.

--=20
Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <=3D=3D Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail:harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Regis Adjamah


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

