Return-Path: virtio-dev-return-4753-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA66D985CA8
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Jul 2018 23:02:24 +0000 (UTC)
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Date: Fri, 27 Jul 2018 23:02:20 +0000
Message-ID: <8EE767E8-480E-4726-80B4-62489DB5B241@intel.com>
References: <1532536840-48601-1-git-send-email-sridhar.samudrala@intel.com>
 <20180727145859.4cbb0f5e.cohuck@redhat.com>,<20180727160035-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180727160035-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v3] content: Introduce
 VIRTIO_NET_F_STANDBY feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>



> On Jul 27, 2018, at 6:03 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
>> On Fri, Jul 27, 2018 at 02:58:59PM +0200, Cornelia Huck wrote:
>> On Wed, 25 Jul 2018 09:40:40 -0700
>> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>>=20
>>> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
>>> device to act as a standby for another device with the same MAC address=
.
>>>=20
>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
>>=20
>> (missing closing bracket)
>>=20
>>> ---
>>> content.tex | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>=20
>> While we certainly need to add more details later, I think we should
>> just go ahead with this now as it at least gives some basic information
>> about the merged feature.
>>=20
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>=20
> Sounds good. Sridhar, for voting to proceed, you need to open a github
> issue, then repost the patch with acks callected and including header
> Fixes: <issue url>

I am on vacation for next 2 weeks.
Will do this after I am back.

>=20
> Ideally you would put something like [PATCH voting-proposal] in the subje=
ct but we
> did not yet standardize on this.
> Thanks!
>=20
> --=20
> MST
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

