Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] [PATCH v3 1/1] virtio-ism: introduce new device
 virtio-ism
Date: Thu, 9 Feb 2023 03:35:33 +0000
Message-ID: <PH0PR12MB5481B554B7956432137B6775DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "hans@linux.alibaba.com" <hans@linux.alibaba.com>, "herongguang@linux.alibaba.com" <herongguang@linux.alibaba.com>, "zmlcc@linux.alibaba.com" <zmlcc@linux.alibaba.com>, "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>, "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>, "zhenzao@linux.alibaba.com" <zhenzao@linux.alibaba.com>, "helinguo@linux.alibaba.com" <helinguo@linux.alibaba.com>, "gerry@linux.alibaba.com" <gerry@linux.alibaba.com>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, "wintera@linux.ibm.com" <wintera@linux.ibm.com>, "kgraul@linux.ibm.com" <kgraul@linux.ibm.com>, "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>, "jaka@linux.ibm.com" <jaka@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "twinkler@linux.ibm.com" <twinkler@linux.ibm.com>, "raspl@linux.ibm.com" <raspl@linux.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Xuan,

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Xuan Zhuo

>  conformance.tex |  26 +++
>  content.tex     |   1 +
>  virtio-ism.tex  | 573 ++++++++++++++++++++++++++++++++++++++++++++++++

Can you please rebase your patches?
Devices are placed under their own directory and maintained in multiple sma=
ller files.

device-types/ism/...

