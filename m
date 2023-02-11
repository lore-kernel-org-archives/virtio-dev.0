Return-Path: <virtio-dev-return-10921-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 11 Feb 2023 18:50:07 +0000
Message-ID: <PH0PR12MB5481404A10B043AF5EE45B2EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-2-mst@redhat.com>
In-Reply-To: <20230209121221.15118-2-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v10 01/10] virtio: document forward compatibility
 guarantees
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:14 AM
>=20
> Feature negotiation forms the basis of forward compatibility guarantees o=
f
> virtio but has never been properly documented.
> Do it now.
>=20
> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index 0e474dd..0c2d917 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities o=
f a
> Virtio Device / Feature B  In particular, new fields in the device config=
uration
> space are  indicated by offering a new feature bit.
>=20
> +To keep the feature negotiation mechanism extensible, it is important
> +that devices \em{do not} offer any feature bits that they would not be
> +able to handle if the driver accepted them (even though drivers are not
> +supposed to accept them in the first place even if offered, according
> +to this version of the specification.) Likewise, it is important that
> +drivers \em{do not} accept feature bits they do not know how to handle
> +(even though devices are not supposed to offer them in the first place,
> +according to this version of the specification.) The preferred way for
> +handling reserved and unexpected features is that the driver ignores
> +them.
> +
> +In particular, this is
> +especially important for features limited to specific transports, as
> +enabling these for more transports in future versions of the
> +specification is highly likely to require changing the behaviour from
> +drivers and devices.  Drivers and devices supporting multiple
> +transports need to carefully maintain per-transport lists of allowed
> +features.
> +
>  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio=
 Device /
> Feature Bits}  The driver MUST NOT accept a feature which the device did =
not
> offer,  and MUST NOT accept a feature which requires another feature whic=
h
> was  not accepted.
>=20
> +The driver MUST validate the feature bits offered by the device.
> +The driver MUST ignore and MUST NOT accept any feature bit that is
> +\begin{itemize} \item not described in this specification, \item marked
> +as reserved, \item not supported for the specific transport, \item not
> +defined for the device type.
> +\end{itemize}
> +
>  The driver SHOULD go into backwards compatibility mode  if the device do=
es
> not offer a feature it understands, otherwise MUST  set the FAILED \field=
{device
> status} bit and cease initialization.
>=20
> +By contrast, the driver MUST NOT fail solely because a feature it does
> +not understand has been offered by the device.
> +
>  \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio=
 Device /
> Feature Bits}  The device MUST NOT offer a feature which requires another
> feature  which was not offered.  The device SHOULD accept any valid subse=
t  of
> features the driver accepts, otherwise it MUST fail to set the  FEATURES_=
OK
> \field{device status} bit when the driver writes it.
>=20
> +The device MUST NOT offer feature bits corresponding to features it
> +would not support if accepted by the driver (even if the driver is
> +prohibited from accepting the feature bits by the specification); for
> +the sake of clarity, this refers to feature bits not described in this
> +specification, reserved feature bits and feature bits reserved or not
> +supported for the specific transport or the specific device type, but
> +this does not preclude devices written to a future version of this
> +specification from offering such feature bits should such a
> +specification have a provision for devices to support the corresponding
> +features.
> +
>  If a device has successfully negotiated a set of features  at least once=
 (by
> accepting the FEATURES_OK \field{device  status} bit during device
> initialization), then it SHOULD
> --
> MST

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

