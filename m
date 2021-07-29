Return-Path: <virtio-dev-return-8443-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B27B986476
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jul 2021 16:19:25 +0000 (UTC)
Date: Thu, 29 Jul 2021 17:19:18 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210729161918.GO6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-16-cristian.marussi@arm.com>
 <20210728153647.llr6bfhyja5ezkth@bogus>
MIME-Version: 1.0
In-Reply-To: <20210728153647.llr6bfhyja5ezkth@bogus>
Subject: [virtio-dev] Re: [PATCH v6 15/17] firmware: arm_scmi: Add optional
 link_supplier() transport op
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 04:36:47PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:31PM +0100, Cristian Marussi wrote:
> > From: Peter Hilber <peter.hilber@opensynergy.com>
> > 
> > Some transports are also effectively registered with other kernel subsystem
> > in order to be properly probed and initialized; as a consequence such kind
> > of transports, and their related devices, might still not have been probed
> > and initialized at the time the main SCMI core driver is probed.
> > 
> > Add an optional .link_supplier() transport operation which can be used by
> > the core SCMI stack to dynamically check if the transport is ready and
> > dynamically link its device to the platform instance device.
> >
> 
> To be precise,
> 
> s/platform instance device/SCMI platform instance device

Yes I'll fix.

Thanks,
Cristian


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

