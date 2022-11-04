Return-Path: <virtio-dev-return-10117-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 519AD9865F5
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Nov 2022 10:51:11 +0000 (UTC)
Mime-Version: 1.0
Message-Id: <ed2d2ea7-4a8c-4616-bca4-c78e6f260ba9@app.fastmail.com>
In-Reply-To: <8bd1dc3b-e1f0-e7f9-bf65-8d243c65adb5@opensynergy.com>
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <CAK8P3a1biW1qygRS8Mf0F5n8e6044+W-5v+Gnv+gh+Cyzj-Vjg@mail.gmail.com>
 <8bd1dc3b-e1f0-e7f9-bf65-8d243c65adb5@opensynergy.com>
Date: Fri, 04 Nov 2022 11:50:45 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [virtio-dev] [RFC PATCH 1/1] can: virtio: Initial virtio CAN driver.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Harald Mommer <hmo@opensynergy.com>, Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 3, 2022, at 13:26, Harald Mommer wrote:
> On 25.08.22 20:21, Arnd Bergmann wrote:
>>
...
> The messages are not necessarily processed in sequence by the CAN stack.=
=20
> CAN is priority based. The lower the CAN ID the higher the priority. So=
=20
> a message with CAN ID 0x100 can surpass a message with ID 0x123 if the=20
> hardware is not just simple basic CAN controller using a single TX=20
> mailbox with a FIFO queue on top of it.
>
> Thinking about this the code becomes more complex with the array. What I=
=20
> get from the device when the message has been processed is a pointer to=
=20
> the processed message by virtqueue_get_buf(). I can then simply do a=20
> list_del(), free the message and done.

Ok

>>> +#ifdef DEBUG
>>> +static void __attribute__((unused))
>>> +virtio_can_hexdump(const void *data, size_t length, size_t base)
>>> +{
>>> +#define VIRTIO_CAN_MAX_BYTES_PER_LINE 16u
>> This seems to duplicate print_hex_dump(), maybe just use that?
> Checked where it's still used. The code is not disabled by #ifdef DEBUG=
=20
> but simply commented out. Under this circumstances it's for now best to=
=20
> simply remove the code now and also the commented out places where is=20
> was used at some time in the past.

Even better.

>>> +
>>> +       while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq)=
)
>>> +               cpu_relax();
>>> +
>>> +       mutex_unlock(&priv->ctrl_lock);
>> A busy loop is probably not what you want here. Maybe just
>> wait_for_completion() until the callback happens?
>
> Was done in the same way as elsewhere=20
> (virtio_console.c/__send_control_msg() &=20
> virtio_net.c/virtnet_send_command()). Yes, wait_for_completion() is=20
> better, this avoids polling.

Ok. FWIW, The others seem to do it like this because they
are in non-atomic context where it is not allowed to call
wait_for_completion(), but since you already have the
mutex here, you know that sleeping is permitted.=20

>>> +       /* Push loopback echo. Will be looped back on TX interrupt/TX N=
API */
>>> +       can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);
>>> +
>>> +       err =3D virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOM=
IC);
>>> +       if (err !=3D 0) {
>>> +               list_del(&can_tx_msg->list);
>>> +               virtio_can_free_tx_idx(priv, can_tx_msg->prio,
>>> +                                      can_tx_msg->putidx);
>>> +               netif_stop_queue(dev);
>>> +               spin_unlock_irqrestore(&priv->tx_lock, flags);
>>> +               kfree(can_tx_msg);
>>> +               if (err =3D=3D -ENOSPC)
>>> +                       netdev_info(dev, "TX: Stop queue, no space left=
\n");
>>> +               else
>>> +                       netdev_warn(dev, "TX: Stop queue, reason =3D %d=
\n", err);
>>> +               return NETDEV_TX_BUSY;
>>> +       }
>>> +
>>> +       if (!virtqueue_kick(vq))
>>> +               netdev_err(dev, "%s(): Kick failed\n", __func__);
>>> +
>>> +       spin_unlock_irqrestore(&priv->tx_lock, flags);
>> There should not be a need for a spinlock or disabling interrupts
>> in the xmit function. What exactly are you protecting against here?
>
> I'm using 2 NAPIs, one for TX and one for RX. The RX NAPI just receives=
=20
> RX messages and is of no interest here. The TX NAPI handles the TX=20
> messages which have been processed by the virtio CAN device in=20
> virtio_can_read_tx_queue(). If this was done without the TX NAPI this=20
> would have been done by the TX interrupt directly, no difference.
>
> In virtio_can_start_xmit()
>
> * Reserve putidx - done by an own mechanism using list operations in=20
> tx_putidx_list
>
> Could be that it's simpler to use idr_alloc() and friends getting those=
=20
> numbers to get rid of this own mechanism, not sure yet. But this needs a=
=20
> locks as it's based on a linked list and the list operation has to be=20
> protected.

Right, makes sense. Lockless transmission should generally work
if your transmission queue is a strictly ordered ring buffer
where you just need to atomically update the index, but you are
right that this doesn't work with a linked list.

This probably directly ties into the specification of your
tx virtqueue: if the device could guarantee that any descriptors
are processed in sequence, you could avoid the spinlock in the
tx path for a small performance optimization, but then you have
to decide on the sequence in the driver already, which impacts
the latency for high-priority frames that get queued to the
device. It's possible that the reordering in the device would
not be as critical if you correctly implement the byte queue
limits.

>>> +       kfree(can_tx_msg);
>>> +
>>> +       /* Flow control */
>>> +       if (netif_queue_stopped(dev)) {
>>> +               netdev_info(dev, "TX ACK: Wake up stopped queue\n");
>>> +               netif_wake_queue(dev);
>>> +       }
>> You may want to add netdev_sent_queue()/netdev_completed_queue()
>> based BQL flow control here as well, so you don't have to rely on the
>> queue filling up completely.
> Not addressed, not yet completely understood.

https://lwn.net/Articles/454390/ is an older article but should still
explain the background. Without byte queue limits, you risk introducing
unbounded TX latency on a congested interface.

Ideally, the host device implementation should only send
back the 'completed' interrupt after a frame has left the
physical hardware. In this case, BQL will manage both the
TX queue in the guest driver and the queue in the host
device to keep the total queue length short enough to
guarantee low latency even for low-priority frames but
long enough to maintain wire-speed throughput.

>>> +
>>> +       register_virtio_can_dev(dev);
>>> +
>>> +       /* Initialize virtqueues */
>>> +       err =3D virtio_can_find_vqs(priv);
>>> +       if (err !=3D 0)
>>> +               goto on_failure;
>> Should the register_virtio_can_dev() be done here? I would expect this t=
o be
>> the last thing after setting up the queues.
>
> Doing so makes the code somewhat simpler and shorter =3D better.

The problem is that as soon as an interface is registered,
you can have userspace sending data to it. This may be
a short race, but I fear that this would cause data corruption
if data gets queued before the device is fully operational.

>>> +#ifdef CONFIG_PM_SLEEP
>>> +       .freeze =3D       virtio_can_freeze,
>>> +       .restore =3D      virtio_can_restore,
>>> +#endif
>> You can remove the #ifdef here and above, and replace that with the
>> pm_sleep_ptr() macro in the assignment.
>
> This pm_sleep_ptr(_ptr) macro returns either the argument when=20
> CONFIG_PM_SLEEP is defined or NULL. But in struct virtio_driver there is
>
> #ifdef CONFIG_PM =C2=A0 int(*freeze) ...; =C2=A0 int(*restore) ...; #endi=
f
>
> so without CONFIG_PM there are no freeze and restore structure members.
>
> So
>
>  =C2=A0 .freeze =3D pm_sleep_ptr(virtio_can_freeze)
>
> won't work.

I think this is a mistake in the virtio_driver definition,
it would be best to send a small patch that removes this
#ifdef along with your driver.

       Arnd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

