Return-Path: <virtio-dev-return-12577-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AB0C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:15:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A183F419B4
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:15:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 865E29866C0
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:15:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 75BB098665E; Fri,  5 May 2023 15:15:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E1DE9866B4;
	Fri,  5 May 2023 15:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOCZ14Uufybulbne1c2KpIlnvB+ikEMWERlD+mFBpOCIrgB9fdjYrRJP34+NyhulGap8OBZGnXXv+Jp5/zEOkbuohfjg10e9KJ8g48JUe2nWoQ52Hcxca/fraJW3SpQBnTyJUws5OXQlN8vrbXFCwjlGq6xKKhfYkNV5waMtDHIh6TzQX4DqJhmJjWtxaeiAfU+o/k6Bh//C97io/WdwsO8A2C/Bmda2Fuc/xIWmJGGGyxTMLc8lFlKcDzBW0LusRJLxI1exZekAja/wjuvo1B1bom4eoOoTa8ujw81pQDNbAi3v+H1T4wWu79IvnM7zr4TU0pCBKrFG5GwL8i7BWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7p1s4jUkkRlyJlqW+owUa8QaR8g2Ek/byfRlGwCQZo=;
 b=fd4uyeKo7sF7sr0boNmUxE0uhSJjiRmfkbwXoRzebVJVMogLUtgS1JgmqhOYYnE6tK2+w1SzhHa/Oba0MJ2XzWosJFFJ+0PBR9PLc8HSCjwjwvNTAiSQ8D8DMw8ywiIrc8FEA4+1fLUzC5R6505sKaRhqbTJndqAzDZHgxfS/V1D+siwy3KFlAMtjs6Mfo1evU5ECjKr3vk4SsdY45AgkN7fV6cXHEPAJpfhvNa0EcTFyYnaxnxtPPfORv82tfcthLz3ILBG1vEG993C7TgnPf78Iy5b0BZALB9vb30xhnVktpGmOjKk5KmfzakmsRcsfPZluq1hiwZlJX90QlhoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci
Thread-Index:
 AQHZdswSyG/pcJpYf0OyhtV/kRPNfq87BFIAgAACO4CAAxNugIAADL9ggAAJXoCAABmgsIANkJKAgAAAgeA=
Date: Fri, 5 May 2023 15:14:58 +0000
Message-ID:
 <PH0PR12MB5481A96ED38161DE8F5C9F16DC729@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
 <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
 <a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com>
 <5cb79b37-a066-283c-eee7-afd26146d988@nvidia.com>
 <PH0PR12MB5481B60350D145531A43E567DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b7addd39-d913-700f-ac67-1412825d580b@nvidia.com>
 <PH0PR12MB54819792ED9279E66B63AC26DC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230505111144-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230505111144-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5370:EE_
x-ms-office365-filtering-correlation-id: 4ec5bdd2-790a-4adb-2501-08db4d7b7d7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /uWFzbmJXrsn/z0qZMmQ05KqOjiUbS+FZz3J76qdvyGJAnLzjIKEftnNHgDqVDCp5VDzKtSHlPdHi1jxBhGj0VILhgwsYs2Jj6YxzoyAxs+RdRhY31wmnFEvSvIxMnkozXQyLK1CIJr/FJsQXI0ahKAOQ7PnIZX18qtLOjV7uXKCcdXpOcedV5mUXa9dbrZKtEDWkyOG0GQ6Zq0QukZdxvBsBHhX+yO1sNyjcboDkNb9XuVpyOMP8U751n94JQTHdYk+fcjeEeHU4wHxAaNFtMIfFB6l22QoLfwyti07QA9F3Urf5EDEari+NoRrrtipHk4Dim9ummMJ1j1W0X2XCQQfoPThS6gCePZBkS5f41Z+He8246CVs+aS0/OqWxuDKpfCCnN0LrdJklI2oqiss6NjFJVX5XFgxG1xI2g8Gzba5/y5vstO0Wdn12DTNDUMtSRpD+/MdeLYPyvCy74fSVeRt/bY2wSWWXgTvRCC205uZ9VIwUBRuA8Y6C7vg4RCA/gjNPZXw0VGxQLSdwl4qGSnZHTAOauTmxbfp8YJb1uzZ+ilq8Ol++oNHlWBFeQ5rEQJx5btpD/ADN8yrmLlpBZjD9bRfXyv4c0FAwCay+5mAqYQ3SBkFD8MQAAHszXwvpMqrvTKx+wxnzmkWxjBhw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(966005)(478600001)(66446008)(64756008)(6916009)(4326008)(76116006)(66556008)(7696005)(66946007)(66476007)(316002)(54906003)(86362001)(33656002)(83380400001)(107886003)(6506007)(26005)(9686003)(71200400001)(8936002)(5660300002)(52536014)(41300700001)(7416002)(4744005)(2906002)(8676002)(55016003)(38070700005)(186003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T3D1AQeaikofvXAwwXBv1lEQ4m6BnpC0JaIFn3aWIiJmfVpXC7+eal8MZV1y?=
 =?us-ascii?Q?ao24usA8JaNffEGSN7PgdGLAdGbxf13uBMVAI4F+qTYda2+/7L+LnGQAx5hY?=
 =?us-ascii?Q?PfpntGXt6C3xpQMy+A3HX4rQ0RLYcuvL0P9Yp2vX7n+vO98DnG8MFTOzr59B?=
 =?us-ascii?Q?ZICYAOlv35RdyN7USmAxJFdUXSdG785mY9i+yoCPGRaBLMK+3PlS/VaPt+Zg?=
 =?us-ascii?Q?BEKiYdv9dRuviSF29xedO4sXBU+7BkYUcOCF5ROGUHaHWj1y4j7PIWAcoDxc?=
 =?us-ascii?Q?/Czgq5AQ/KSUk1mMdpNry6T3hMzL8Xctk49GgH4BZHr+863jB6ZVP8tYgAOs?=
 =?us-ascii?Q?Lz6KGS5TysmmINQml/UQAKReUQRXl1TBhs//z56GfFHc9T9PnaNFREra3eXl?=
 =?us-ascii?Q?nK5EIPOEeA7qvWieut8AZGsypl/7KovKeQ21gFYX5zHbYQXTDJgu9EeXwiNx?=
 =?us-ascii?Q?F+8rVdO9EV7+bVuObLcieVy7FIpeMvny+Rwd1OXnOsPIEXrT8TlSKxoxT0Lx?=
 =?us-ascii?Q?CW8NqkP3Vl+vtcCEDrO9xIF1EyApmPtq9tKW4l0DjH4m0B2pw/hOZY0+H5to?=
 =?us-ascii?Q?81uOsn/tyrTOD5VT4S77PB3abfwPBeOscW6yrB5gjvNMhM9/BLFNxDCpyWPu?=
 =?us-ascii?Q?kDBJ8KU+JF0Me0HGaEQTbUC+qRNuIa1cttEesPvRxguOIKoNjoosDcJJZ8JT?=
 =?us-ascii?Q?KoL4mJyJrB+Ygkgc4rEQOm7rPRJ0IwF+auXLJBm7vSKuaSf/OODkkz1v2YOY?=
 =?us-ascii?Q?aS1JxxOzklgkKt7cul3jBNdCP0pikWrJZ66sNULczbez8aWy8CLO9IzfEep5?=
 =?us-ascii?Q?xkVeJL1T87j8XyKqMxbyx7Vz7Hz3iaxaf11RDbR0Og2isW+UBJ/UjvGq1xGl?=
 =?us-ascii?Q?22zw7MLZQAc08kcmarbInk8ERRLmYR0oWFQPSQ9R1pyHJTEr6vn5ORs/ZhrU?=
 =?us-ascii?Q?eikIB3FvXRodMwjhFHOL7yzgy3mLKLy3WaCUZeaWdD/4rYrVgB+52rWfhybO?=
 =?us-ascii?Q?ftwpikU+SXVh9S29Uz+BlxIVAaLEhjIxiS3wULi8j5MIQY2AH3++P+J/9G0C?=
 =?us-ascii?Q?bmSnnvmdbIlES6xLUg5OGtLyYoYlnbObRfbPn8akZvQHvwMUKbH9qb5JBZzv?=
 =?us-ascii?Q?/qNFZ7ATs0eANN/gf1ikCdX0ITpjMS9G8r8ItNKEqJsADciVO5sN+2Bkoj62?=
 =?us-ascii?Q?a5RcNrgWucvhY6qI77vQWBv2Sr7bthAcy6XFDfsuRcIGei4uiVu9ODN3Kcas?=
 =?us-ascii?Q?sJRFcyf4vXUPDViS/3bZXs0V9PF3wYPjbgz7H/llt1/RpoWcfRZYs6WkA0ux?=
 =?us-ascii?Q?DGgdttV5JwjAwY4jaDlhOyaqGRH+e8O0fsXeJmJVslBeZiFxB8bE7OCMMqZh?=
 =?us-ascii?Q?cDWThAgx2Wy0VXZZENOC/T5s5VoapqSF8JbZVf0/TlqrZKh1vk75nYh+cAMe?=
 =?us-ascii?Q?lzx/yWgtjeSACpV9wPLgB1rNWSonWWQ81ofZD+Z4Gl9jEbA5nOsWElsDsUkx?=
 =?us-ascii?Q?F/8KsCWfvAEOUAA4USCLqDifYqteiqF+/thBoA3TMBzxO6Fm+hrQK1J1mPHa?=
 =?us-ascii?Q?kETnErX1zGwZ2Ut8N5U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec5bdd2-790a-4adb-2501-08db4d7b7d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 15:14:58.4502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /K6m2IBYmIQ1lEiXmKdCMbo9w8yjzSha433ttkwLfPICEM2tPVjstbKb0zJZ4/UY8De0QQjwG9oNhJo0q4M3yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5370
Subject: [virtio-dev] RE: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, May 5, 2023 11:12 AM

> > "I am thinking that aq index should not overlap with the vq index in ra=
nge
> exposed by num_queues field."
> >
> > So, admin_queue_index description needs to have description like below.
> >
> > admin_queue_index must be greater than or equal to the value of
> num_queues.
> >
> > Yes?
> >
> > [1]
> > https://lore.kernel.org/virtio-dev/a4b1596c-2132-714a-7557-fa5249a5594
> > 5@nvidia.com/
>=20
>=20
> this is present in the conformance clause patch:
>=20
> +If VIRTIO_F_ADMIN_VQ has been negotiated, the value
> +\field{admin_queue_index} MUST be equal to, or bigger than
> +\field{num_queues}; also, \field{admin_queue_num} MUST be smaller than,
> +or equal to 0x10000 - \field{admin_queue_index}, to ensure that indices
> +of valid admin queues fit into a 16 bit range beyond all other
> +virtqueues.
Yes. this covers it. I read it before in your reply to Max few days back.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

