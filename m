Return-Path: <virtualization-bounces@lists.linux-foundation.org>
Date: Mon, 14 Jun 2021 12:43:52 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 00/16] Introduce SCMI VirtIO transport
Message-ID: <YMdA+GkgJ+GONuJr@infradead.org>
References: <20210611165937.701-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: virtio-dev@lists.oasis-open.org, mikhail.golubev@opensynergy.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, igor.skalkin@opensynergy.com, jean-philippe@linaro.org, Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Vasyl.Vavrychuk@opensynergy.com, peter.hilber@opensynergy.com, james.quinlan@broadcom.com, sudeep.holla@arm.com, souvik.chakravarty@arm.com, etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 11, 2021 at 05:59:21PM +0100, Cristian Marussi wrote:
> Hi all,
> 
> I'm posting this V4 series starting from the work done up to V3 by
> OpenSynergy.

Who is 'OpenSynergy'?

> The main aim of this rework is to simplify where possible the SCMI VirtIO
> support added in V3 by adding upfront and then using some new mechanisms in
> the SCMI Core Transport layer.

And what is 'SCMI', and why would anyone want a new virtio transport?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
