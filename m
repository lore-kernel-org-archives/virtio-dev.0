Return-Path: <virtio-dev-return-8425-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48B8E98647A
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jul 2021 17:25:57 +0000 (UTC)
Date: Wed, 28 Jul 2021 18:25:46 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210728172546.GL6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-9-cristian.marussi@arm.com>
 <20210728142625.zbx7zbeffwsksjl5@bogus>
MIME-Version: 1.0
In-Reply-To: <20210728142625.zbx7zbeffwsksjl5@bogus>
Subject: [virtio-dev] Re: [PATCH v6 08/17] firmware: arm_scmi: Add priv parameter to
 scmi_rx_callback
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 03:26:25PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:24PM +0100, Cristian Marussi wrote:
> > Add a new opaque void *priv parameter to scmi_rx_callback which can be
> > optionally provided by the transport layer when invoking scmi_rx_callback
> > and that will be passed back to the transport layer in xfer->priv.
> > 
> > This can be used by transports that needs to keep track of their specific
> > data structures together with the valid xfers.
> >

Hi,

> 
> This change looks simple but doesn't make sense on its own. I assume you don't
> want to add all these in the patch making use of priv which makes sense. Not
> sure if the next patch uses it, but I prefer to keep them as close as possible
> if it is not too much of a hassle.
> 

Right, yes I'll move it close to 17/17 which is the actual user of this
at the end.

Thanks,
Cristian


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

