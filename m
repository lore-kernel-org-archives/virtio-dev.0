Return-Path: <jean-philippe@linaro.org>
Date: Wed, 26 Jan 2022 09:27:14 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Message-ID: <YfET8pNaYoWZ6eFt@myrica>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
 <87k0eud0bi.fsf@redhat.com>
 <20220121033806.70b55223.pasic@linux.ibm.com>
 <87r191krbg.fsf@redhat.com>
 <20220124174052.1b6b423e.pasic@linux.ibm.com>
 <20220124132837-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220124132837-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Viresh Kumar <viresh.kumar@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 24, 2022 at 04:42:35PM -0500, Michael S. Tsirkin wrote:
> So from that point of view, we are actually relaxing the requirements,
> and yes we'll need to carefully go over each instance of
> "offered".
> I thought I did, but now I did a quick grep again and I found instances
> in virtio-iommu.tex and virtio-gpio.tex
> Both of these are new, so I think we can just fix them to "negotiated".
> 
> Jean-Philippe, Viresh, what do you think? Would it be a problem to
> replace offered with negotiated, and restrict iommu and gpio drivers to
> access config space after FEATURES_OK?

No problem for iommu. The config space fields domain_range and input_range
are not useful to the driver before DRIVER_OK. Reading field bypass
earlier could be useful for debugging, but in that case going a few more
steps into device initialization wouldn't hurt.

Thanks,
Jean

