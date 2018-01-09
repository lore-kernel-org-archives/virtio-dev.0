Return-Path: virtio-dev-return-2935-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 67C635818CAB
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Jan 2018 09:41:27 -0800 (PST)
Date: Tue, 9 Jan 2018 19:41:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180109193800-mutt-send-email-mst@kernel.org>
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
 <1514626559-162312-2-git-send-email-longpeng2@huawei.com>
 <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [v23 1/2] virtio-crypto: Add virtio crypto device
 specification
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 09, 2018 at 06:05:41PM +0100, Halil Pasic wrote:
> > +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
> > +
> > +\begin{itemize*}
> > +\item The driver MUST read the \field{status} from the bottom bit of status to check whether the
> > +    VIRTIO_CRYPTO_S_HW_READY is set, and the driver MUST reread it after device reset.
> > +\item The driver MUST NOT transmit any requests to the device if the VIRTIO_CRYPTO_S_HW_READY is not set.
> > +\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.
> > +\item The driver MUST read \field{crypto_services} field to discover which services the device is able to offer.
> > +\item The driver SHOULD ignore the not defined algorithms bits.
> > +\item The driver MUST read the detailed algorithms fields based on \field{crypto_services} field.
> > +\item The driver SHOULD read \field{max_size} to discover the maximum size of crypto request the device supports.
> > +\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
> > +    the device supports.
> > +\item The driver SHOULD read \field{max_auth_key_len} to discover the maximum length of authenticated
> > +    key the device supports.
> > +\end{itemize*}
> 
> Seems to like a common practice in the virtio spec to say SHOULD read some
> config space parameter in a driver normative but then having no driver normative
> about the operational implications of the parameter.
> 
> While I do think that the reader is usually fully capable of inferring
> the operational requirement, I find it a bit strange: having the operational
> stuff explicit (and possibly needs to be read from the config space implicit)
> seems more straight forward to me.
> 
> Anyway, you are consistent with the rest of the spec, so prefer keeping it
> like this.

The reason for this in virtio generally is that driver is really
only required to be consistent with the device.
Something like reading the value once and storing in e.g.
registry, then using the stored value from registry on
following values seems to also be ok.

Restricting values below the limits allowed by the device
also seems to be ok.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

