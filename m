Return-Path: <virtio-dev-return-8214-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2AE979862C0
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 08:42:54 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-5-cristian.marussi@arm.com>
Message-ID: <cb7f3259-0ad5-8ce0-15e7-2abee1f704ff@opensynergy.com>
Date: Thu, 1 Jul 2021 10:42:45 +0200
In-Reply-To: <20210611165937.701-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 04/16] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

I find `monotonically increasing tokens' misleading, since the token may=20
wrap around quite often during normal usage. How about `modulo=20
incrementing'?

On 11.06.21 18:59, Cristian Marussi wrote:
> Tokens are sequence numbers embedded in the each SCMI message header: the=
y
> are used to correlate commands with responses (and delayed responses), bu=
t
> their usage and policy of selection is entirely up to the caller (usually
> the OSPM agent), while they are completely opaque to the callee (SCMI
> server platform) which merely copies them back from the command into the
> response message header.
> This also means that the platform does not, can not and should not enforc=
e
> any kind of policy on received messages depending on the contained sequen=
ce
> number: platform can perfectly handle concurrent requests carrying the sa=
me
> identifiying token if that should happen.
>=20
> Moreover the platform is not required to produce in-order responses to
> agent requests, the only constraint in these regards is that in case of
> an asynchronous message the delayed response must be sent after the
> immediate response for the synchronous part of the command transaction.
>=20
> Currenly the SCMI stack of the OSPM agent selects a token for the egressi=
ng
> commands picking the lowest possible number which is not already in use b=
y
> an existing in-flight transaction, which means, in other words, that we
> immediately reuse any token after its transaction has completed or it has
> timed out: this policy indeed does simplify management and lookup of toke=
ns
> and associated xfers.
>=20
> Under the above assumptions and constraints, since there is really no sta=
te
> shared between the agent and the platform to let the platform know when a
> token and its associated message has timed out, the current policy of ear=
ly
> reuse of tokens can easily lead to the situation in which a spurious or
> late received response (or delayed_response), related to an old stale and
> timed out transaction, can be wrongly associated to a newer valid in-flig=
ht
> xfer that just happens to have reused the same token.
>=20
> This misbehaviour on such ghost responses is more easily exposed on those
> transports that naturally have an higher level of parallelism in processi=
ng
> multiple concurrent in-flight messages.
>=20
> This commit introduces a new policy of selection of tokens for the OSPM
> agent: each new transfer now gets the next available and monotonically
> increasing token, until tokens are exhausted and the counter rolls over.
>=20
> Such new policy mitigates the above issues with ghost responses since the
> tokens are now reused as late as possible (when they roll back ideally)
> and so it is much easier to identify such ghost responses to stale timed
> out transactions: this also helps in simplifying the specific transports
> implementation since stale transport messages can be easily identified
> and discarded early on in the rx path without the need to cross check
> their actual state with the core transport layer.
> This mitigation is even more effective when, as is usually the case, the
> maximum number of pending messages is capped by the platform to a much
> lower number than the whole possible range of tokens values (2^10).
>=20
> This internal policy change in the core SCMI transport layer is fully
> transparent to the specific transports so it has not and should not have
> any impact on the transports implementation.
>=20
> The empirically observed cost of such new procedure of token selection
> amounts in the best case to ~10us out of an observed full transaction cos=
t
> of 3ms for the completion of a synchronous sensor reading command on a
> platform supporting commands completion interrupts.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h |  23 +++
>  drivers/firmware/arm_scmi/driver.c | 243 +++++++++++++++++++++++++----
>  2 files changed, 233 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_sc=
mi/common.h
> index 6bb734e0e3ac..e64c5ca9ee7c 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -14,7 +14,10 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> +#include <linux/hashtable.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/refcount.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/types.h>
> =20
> @@ -127,6 +130,21 @@ struct scmi_msg {
>  =09size_t len;
>  };
> =20
> +/**
> + * An helper macro to lookup an xfer from the @pending_xfers hashtable
> + * using the message sequence number token as a key.
> + */
> +#define XFER_FIND(__ht, __k)=09=09=09=09=09\
> +({=09=09=09=09=09=09=09=09\
> +=09typeof(__k) k_ =3D __k;=09=09=09=09=09\
> +=09struct scmi_xfer *xfer_ =3D NULL;=09=09=09=09\
> +=09=09=09=09=09=09=09=09\
> +=09hash_for_each_possible((__ht), xfer_, node, k_)=09=09\
> +=09=09if (xfer_->hdr.seq =3D=3D k_)=09=09=09\
> +=09=09=09break;=09=09=09=09=09\
> +=09 xfer_;=09=09=09=09=09=09=09\

There is an extra space before the return value.

> +})
> +
>  /**
>   * struct scmi_xfer - Structure representing a message flow
>   *
> @@ -138,6 +156,9 @@ struct scmi_msg {
>   *=09buffer for the rx path as we use for the tx path.
>   * @done: command message transmit completion event
>   * @async_done: pointer to delayed response message received event compl=
etion
> + * @users: A refcount to track the active users for this xfer
> + * @node: An hlist_node reference used to store this xfer, alternatively=
, on
> + *=09  the free list @free_xfers or in the @pending_xfers hashtable
>   */
>  struct scmi_xfer {
>  =09int transfer_id;
> @@ -146,6 +167,8 @@ struct scmi_xfer {
>  =09struct scmi_msg rx;
>  =09struct completion done;
>  =09struct completion *async_done;
> +=09refcount_t users;
> +=09struct hlist_node node;
>  };
> =20
>  struct scmi_xfer_ops;
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_sc=
mi/driver.c
> index 20f8f0581f3a..f0b20ddb24f4 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/ktime.h>
> +#include <linux/hashtable.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -65,19 +66,29 @@ struct scmi_requested_dev {
>  =09struct list_head node;
>  };
> =20
> +#define SCMI_PENDING_XFERS_HT_ORDER_SZ=099

Micro-optimization note: This increases struct scmi_info size to > 8 kiB=20
(on 64-bit architectures). A lower size of the hash table would be=20
enough for some transports.

> +
>  /**
>   * struct scmi_xfers_info - Structure to manage transfer information
>   *
> - * @xfer_block: Preallocated Message array
>   * @xfer_alloc_table: Bitmap table for allocated messages.
>   *=09Index of this bitmap table is also used for message
>   *=09sequence identifier.
>   * @xfer_lock: Protection for message allocation
> + * @last_token: A counter to use as base to generate for monotonically
> + *=09=09increasing tokens.
> + * @free_xfers: A free list for available to use xfers. It is initialize=
d with
> + *=09=09a number of xfers equal to the maximum allowed in-flight
> + *=09=09messages.
> + * @pending_xfers: An hashtable, indexed by msg_hdr.seq, used to keep al=
l the
> + *=09=09   currently in-flight messages.
>   */
>  struct scmi_xfers_info {
> -=09struct scmi_xfer *xfer_block;
>  =09unsigned long *xfer_alloc_table;
>  =09spinlock_t xfer_lock;
> +=09atomic_t last_token;
> +=09struct hlist_head free_xfers;
> +=09DECLARE_HASHTABLE(pending_xfers, SCMI_PENDING_XFERS_HT_ORDER_SZ);
>  };
> =20
>  /**
> @@ -203,6 +214,117 @@ void *scmi_notification_instance_data_get(const str=
uct scmi_handle *handle)
>  =09return info->notify_priv;
>  }
> =20
> +/**
> + * scmi_xfer_token_set  - Reserve and set new token for the xfer at hand
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel typ=
e
> + * @xfer: The xfer to act upon
> + *
> + * Pick the next unused monotonically increasing token and set it into
> + * xfer->hdr.seq: picking a monotonically increasing value avoids immedi=
ate
> + * reuse of freshly completed or timed-out xfers, thus mitigating the ri=
sk
> + * of incorrect association of a late and expired xfer with a live in-fl=
ight
> + * transaction, both happening to re-use the same token identifier.
> + *
> + * Since platform is NOT required to answer our request in-order we shou=
ld
> + * account for a few rare but possible scenarios:
> + *
> + *  - exactly 'next_token' may be NOT available so pick xfer_id >=3D nex=
t_token
> + *    using find_next_zero_bit() starting from candidate next_token bit
> + *
> + *  - all tokens ahead upto (MSG_TOKEN_ID_MASK - 1) are used in-flight b=
ut we
> + *    are plenty of free tokens at start, so try a second pass using
> + *    find_next_zero_bit() and starting from 0.
> + *
> + *  X =3D used in-flight
> + *
> + * Normal
> + * ------
> + *
> + *=09=09|- xfer_id picked
> + *   -----------+-------------------------------------------------------=
---
> + *   | | |X|X|X| | | | | | ... ... ... ... ... ... ... ... ... ... ...|X=
|X|
> + *   -------------------------------------------------------------------=
---
> + *=09=09^
> + *=09=09|- next_token
> + *
> + * Out-of-order pending at start
> + * -----------------------------
> + *
> + *=09  |- xfer_id picked, last_token fixed
> + *   -----+-------------------------------------------------------------=
---
> + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... ... ...|X=
| |
> + *   -------------------------------------------------------------------=
---
> + *    ^
> + *    |- next_token
> + *
> + *
> + * Out-of-order pending at end
> + * ---------------------------
> + *
> + *=09  |- xfer_id picked, last_token fixed
> + *   -----+-------------------------------------------------------------=
---
> + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... |X|X|X||X=
|X|
> + *   -------------------------------------------------------------------=
---
> + *=09=09=09=09=09=09=09=09^
> + *=09=09=09=09=09=09=09=09|- next_token
> + *
> + * Context: Assumes to be called with @xfer_lock already acquired.
> + *
> + * Return: 0 on Success or error
> + */
> +static int scmi_xfer_token_set(struct scmi_xfers_info *minfo,
> +=09=09=09       struct scmi_xfer *xfer)
> +{
> +=09unsigned long xfer_id, next_token;
> +
> +=09/* Pick a candidate monotonic token in range [0, MSG_TOKEN_MAX - 1] *=
/
> +=09next_token =3D (atomic_inc_return(&minfo->last_token) &
> +=09=09      (MSG_TOKEN_MAX - 1));
> +
> +=09/* Pick the next available xfer_id >=3D next_token */
> +=09xfer_id =3D find_next_zero_bit(minfo->xfer_alloc_table,
> +=09=09=09=09     MSG_TOKEN_MAX, next_token);
> +=09if (xfer_id =3D=3D MSG_TOKEN_MAX) {
> +=09=09/*
> +=09=09 * After heavily out-of-order responses, there are no free
> +=09=09 * tokens ahead, but only at start of xfer_alloc_table so
> +=09=09 * try again from the beginning.
> +=09=09 */
> +=09=09xfer_id =3D find_next_zero_bit(minfo->xfer_alloc_table,
> +=09=09=09=09=09     MSG_TOKEN_MAX, 0);
> +=09=09/*
> +=09=09 * Something is wrong if we got here since there can be a
> +=09=09 * maximum number of (MSG_TOKEN_MAX - 1) in-flight messages
> +=09=09 * but we have not found any free token [0, MSG_TOKEN_MAX - 1].
> +=09=09 */
> +=09=09if (WARN_ON_ONCE(xfer_id =3D=3D MSG_TOKEN_MAX))
> +=09=09=09return -ENOMEM;
> +=09}
> +
> +=09/* Update +/- last_token accordingly if we skipped some hole */
> +=09if (xfer_id !=3D next_token)
> +=09=09atomic_add((int)(xfer_id - next_token), &minfo->last_token);
> +
> +=09/* Set in-flight */
> +=09set_bit(xfer_id, minfo->xfer_alloc_table);
> +=09xfer->hdr.seq =3D (u16)xfer_id;
> +
> +=09return 0;
> +}
> +
> +/**
> + * scmi_xfer_token_clear  - Release the token
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel typ=
e
> + * @xfer: The xfer to act upon
> + */
> +static inline void scmi_xfer_token_clear(struct scmi_xfers_info *minfo,
> +=09=09=09=09=09 struct scmi_xfer *xfer)
> +{
> +=09clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
> +}
> +
>  /**
>   * scmi_xfer_get() - Allocate one message
>   *
> @@ -212,36 +334,49 @@ void *scmi_notification_instance_data_get(const str=
uct scmi_handle *handle)
>   * Helper function which is used by various message functions that are
>   * exposed to clients of this driver for allocating a message traffic ev=
ent.
>   *
> - * This function can sleep depending on pending requests already in the =
system
> - * for the SCMI entity. Further, this also holds a spinlock to maintain
> - * integrity of internal data structures.
> + * Picks an xfer from the free list @free_xfers (if any available), sets=
 a
> + * monotonically increasing token and stores the inflight xfer into the
> + * @pending_xfers hashtable for later retrieval.
> + *
> + * The successfully initialized xfer is refcounted.
> + *
> + * Context: Holds @xfer_lock while manipulating @xfer_alloc_table and
> + *=09    @free_xfers.
>   *
>   * Return: 0 if all went fine, else corresponding error.
>   */
>  static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
>  =09=09=09=09       struct scmi_xfers_info *minfo)
>  {
> -=09u16 xfer_id;
> +=09int ret;
> +=09unsigned long flags;
>  =09struct scmi_xfer *xfer;
> -=09unsigned long flags, bit_pos;
> -=09struct scmi_info *info =3D handle_to_scmi_info(handle);
> =20
> -=09/* Keep the locked section as small as possible */
>  =09spin_lock_irqsave(&minfo->xfer_lock, flags);
> -=09bit_pos =3D find_first_zero_bit(minfo->xfer_alloc_table,
> -=09=09=09=09      info->desc->max_msg);
> -=09if (bit_pos =3D=3D info->desc->max_msg) {
> +=09if (hlist_empty(&minfo->free_xfers)) {
>  =09=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>  =09=09return ERR_PTR(-ENOMEM);
>  =09}
> -=09set_bit(bit_pos, minfo->xfer_alloc_table);
> -=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> =20
> -=09xfer_id =3D bit_pos;
> +=09/* grab an xfer from the free_list */
> +=09xfer =3D hlist_entry(minfo->free_xfers.first, struct scmi_xfer, node)=
;
> +=09hlist_del_init(&xfer->node);
> =20
> -=09xfer =3D &minfo->xfer_block[xfer_id];
> -=09xfer->hdr.seq =3D xfer_id;
> -=09xfer->transfer_id =3D atomic_inc_return(&transfer_last_id);
> +=09/* Pick and set monotonic token */
> +=09ret =3D scmi_xfer_token_set(minfo, xfer);
> +=09if (!ret) {
> +=09=09hash_add(minfo->pending_xfers, &xfer->node, xfer->hdr.seq);
> +=09} else {
> +=09=09dev_err(handle->dev, "Failed to get monotonic token %d\n", ret);
> +=09=09hlist_add_head(&xfer->node, &minfo->free_xfers);
> +=09=09xfer =3D ERR_PTR(ret);
> +=09}
> +=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +
> +=09if (!IS_ERR(xfer)) {
> +=09=09refcount_set(&xfer->users, 1);

Maybe it would be better to do this inside the lock, so that there is no=20
(unlikely) race with refcount_inc() in scmi_xfer_acquire().

> +=09=09xfer->transfer_id =3D atomic_inc_return(&transfer_last_id);
> +=09}
> =20
>  =09return xfer;
>  }
> @@ -252,6 +387,9 @@ static struct scmi_xfer *scmi_xfer_get(const struct s=
cmi_handle *handle,
>   * @minfo: Pointer to Tx/Rx Message management info based on channel typ=
e
>   * @xfer: message that was reserved by scmi_xfer_get
>   *
> + * After refcount check, possibly release an xfer, clearing the token sl=
ot,
> + * removing xfer from @pending_xfers and putting it back into free_xfers=
.
> + *
>   * This holds a spinlock to maintain integrity of internal data structur=
es.
>   */
>  static void
> @@ -259,16 +397,41 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, stru=
ct scmi_xfer *xfer)
>  {
>  =09unsigned long flags;
> =20
> -=09/*
> -=09 * Keep the locked section as small as possible
> -=09 * NOTE: we might escape with smp_mb and no lock here..
> -=09 * but just be conservative and symmetric.
> -=09 */
>  =09spin_lock_irqsave(&minfo->xfer_lock, flags);
> -=09clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
> +=09if (refcount_dec_and_test(&xfer->users)) {
> +=09=09scmi_xfer_token_clear(minfo, xfer);
> +=09=09hash_del(&xfer->node);
> +=09=09hlist_add_head(&xfer->node, &minfo->free_xfers);
> +=09}
>  =09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>  }
> =20
> +/**
> + * scmi_xfer_lookup_unlocked  -  Helper to lookup an xfer_id
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel typ=
e
> + * @xfer_id: Token ID to lookup in @pending_xfers
> + *
> + * Refcounting is untouched.
> + *
> + * Context: Assumes to be called with @xfer_lock already acquired.
> + *
> + * Return: A valid xfer on Success or error otherwise
> + */
> +static struct scmi_xfer *
> +scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
> +{
> +=09struct scmi_xfer *xfer =3D NULL;
> +
> +=09if (xfer_id >=3D MSG_TOKEN_MAX)
> +=09=09return ERR_PTR(-EINVAL);
> +
> +=09if (test_bit(xfer_id, minfo->xfer_alloc_table))
> +=09=09xfer =3D XFER_FIND(minfo->pending_xfers, xfer_id);
> +
> +=09return xfer ?: ERR_PTR(-EINVAL);
> +}
> +
>  static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 m=
sg_hdr)
>  {
>  =09struct scmi_xfer *xfer;
> @@ -305,19 +468,22 @@ static void scmi_handle_notification(struct scmi_ch=
an_info *cinfo, u32 msg_hdr)
>  static void scmi_handle_response(struct scmi_chan_info *cinfo,
>  =09=09=09=09 u16 xfer_id, u8 msg_type)
>  {
> +=09unsigned long flags;
>  =09struct scmi_xfer *xfer;
>  =09struct device *dev =3D cinfo->dev;
>  =09struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
>  =09struct scmi_xfers_info *minfo =3D &info->tx_minfo;
> =20
>  =09/* Are we even expecting this? */
> -=09if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
> +=09spin_lock_irqsave(&minfo->xfer_lock, flags);
> +=09xfer =3D scmi_xfer_lookup_unlocked(minfo, xfer_id);
> +=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +=09if (IS_ERR(xfer)) {
>  =09=09dev_err(dev, "message for %d is not expected!\n", xfer_id);
>  =09=09info->desc->ops->clear_channel(cinfo);
>  =09=09return;
>  =09}
> =20
> -=09xfer =3D &minfo->xfer_block[xfer_id];
>  =09/*
>  =09 * Even if a response was indeed expected on this slot at this point,
>  =09 * a buggy platform could wrongly reply feeding us an unexpected
> @@ -1033,18 +1199,25 @@ static int __scmi_xfer_info_init(struct scmi_info=
 *sinfo,
>  =09=09return -EINVAL;
>  =09}
> =20
> -=09info->xfer_block =3D devm_kcalloc(dev, desc->max_msg,
> -=09=09=09=09=09sizeof(*info->xfer_block), GFP_KERNEL);
> -=09if (!info->xfer_block)
> -=09=09return -ENOMEM;
> +=09hash_init(info->pending_xfers);
> =20
> -=09info->xfer_alloc_table =3D devm_kcalloc(dev, BITS_TO_LONGS(desc->max_=
msg),
> +=09/* Allocate a bitmask sized to hold MSG_TOKEN_MAX tokens */
> +=09info->xfer_alloc_table =3D devm_kcalloc(dev, BITS_TO_LONGS(MSG_TOKEN_=
MAX),
>  =09=09=09=09=09      sizeof(long), GFP_KERNEL);
>  =09if (!info->xfer_alloc_table)
>  =09=09return -ENOMEM;
> =20
> -=09/* Pre-initialize the buffer pointer to pre-allocated buffers */
> -=09for (i =3D 0, xfer =3D info->xfer_block; i < desc->max_msg; i++, xfer=
++) {
> +=09/*
> +=09 * Preallocate a number of xfers equal to max inflight messages,
> +=09 * pre-initialize the buffer pointer to pre-allocated buffers and
> +=09 * attach all of them to the free list
> +=09 */
> +=09INIT_HLIST_HEAD(&info->free_xfers);
> +=09for (i =3D 0; i < desc->max_msg; i++) {
> +=09=09xfer =3D devm_kzalloc(dev, sizeof(*xfer), GFP_KERNEL);
> +=09=09if (!xfer)
> +=09=09=09return -ENOMEM;
> +
>  =09=09xfer->rx.buf =3D devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
>  =09=09=09=09=09    GFP_KERNEL);
>  =09=09if (!xfer->rx.buf)
> @@ -1052,8 +1225,12 @@ static int __scmi_xfer_info_init(struct scmi_info =
*sinfo,
> =20
>  =09=09xfer->tx.buf =3D xfer->rx.buf;
>  =09=09init_completion(&xfer->done);
> +
> +=09=09/* Add initialized xfer to the free list */
> +=09=09hlist_add_head(&xfer->node, &info->free_xfers);
>  =09}
> =20
> +=09atomic_set(&info->last_token, -1);
>  =09spin_lock_init(&info->xfer_lock);
> =20
>  =09return 0;
>=20




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

