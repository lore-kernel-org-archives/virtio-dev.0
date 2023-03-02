Return-Path: <virtio-dev-return-11380-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A8CC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:10:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7EF6B29FD1
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:10:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A4A298668B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:10:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6FDE8986676; Thu,  2 Mar 2023 15:10:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BE13986674;
	Thu,  2 Mar 2023 15:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIeib9ThkgbpQhVR1R63DMhLE1hQd88kpNF8or+30bBakPDAY4IYCcGgafp5wxjjr1WJrq4loKPIuF7Z8fYdgfTV9QoK+2ScTv5pswXac/Fi9hnb8QHfOs3VoSaH9AuQF8zGJ7voWKm8wadwP/gR/xEZ+OJuBoAYKc5F1ZVA1jwkmLjAKAQU311HKQ2WOpUAZi2iIUdxeFRZnTZcTKQ7hEbpesxbgO2tX8jWuzp6XD9vADdH56AgUZN3IKedxLZXJbR4YHawRUK6BLkstHvEEz3I/gIOuJjU6HwIk2CQSP5mDQJVUUOPny+YZN//82FUPoz+OMtWf+Hws7QWPgB6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmt7GgXZc0IJghv2u/0sm4NTJBm3O9ieR1LAeHDRmEc=;
 b=jAys3ti2lRYdoaFgXwSSo7cN78kWWKAWschia9+lhTqUZY1omXDpEg3BilvaY5u93lgVE8UVRHJNW8NfwwqZKNOhtPiW8AJD61rXCFnPr1KcJWH7rJLNCEBI69lSHoaympBspWusAssNsitfyz0lSUueMeH37tklqbl/9G4p/UdD9FDCJKA7KvynpKlt03xDtGq1mE7thUKZyofDTFePf2MCLmrhHc9JBuurpmfScO9F9D8BOLkzA6ZIXkzEBsghpefjrIKiioXlg0mMPbCZLHfWEhbcGR0M1pKB6TBDkJLYwghoOAWrBt4kxn79FmYaUp+2uGI/lk4kL8fEVp0WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v5 0/6] Split transport specific files
Thread-Index: AQHZSJ6CEnFrLqsy2EqHMs0Tj2pFUK7noGUA
Date: Thu, 2 Mar 2023 15:10:45 +0000
Message-ID:
 <PH0PR12MB54810629E248D17C25CF5B1CDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230224222215.339715-1-parav@nvidia.com>
In-Reply-To: <20230224222215.339715-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7690:EE_
x-ms-office365-filtering-correlation-id: ab3e55b8-7dd3-4d1a-6642-08db1b304c56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WASpjCleLi0AeYA8wNnXbXtJtTuiCBhHu7ysONhzywp53wFSHghRs2x1Z0kW5Q+PHzDzaVloCL/VdTetLTROdWLpdUkjQ7eAoH9Wev1X8r0Ep4NVijTUfYK6DRZv06OhmqbrMnIVTZmjKV5dni1jDVxCsDtZlBPuv0KX43hj/nY9ciMlSB17qyT2F5O846vIvpvmmUDyIb9gogjOrRGPxl6hT4HJDqPe1HKVmqW16AYP20uQYNIX8qjzk2E0NtEGP2Ara08qRYCYvJLkJnwhOtBygqrF/cEkM3OWSF8GJQ+1AO6AHN+NvKqVZ6rNADpNnrt+nz6ubk6DXaXcXrBEng4EqGddi3HUWv32z1TFNkkpDG08ErAtVxhwQLJ2jLpigp5GWA8NvrOFNvmEj8+3W82d/SMBPtXH9qh9buM395RPJ+WyOzYJVVxDHw5eYFQaTfY9y14Xw+79SEiH2nD+lsjYngzI2DHpAz9LORi4CzXTV6yzDB8lsMjQxfTEb3idqrPAyjMXRmaOsnNRuBkXkp+ea4iWO04Yc8Wv97rzD4gCXdEq0HuH0P04pLrwa1qxve1/jFB9omMCXLXRb4Cbf3TcCgfShGVTCiu2AKVlg/AmQn0xuBGqQ1Xd3a6myl1XGxTcqb9RxS51qVxpyRPPB6sGGHQV11XKYpgmAJEhchp82kL4HiTiItSzlVBxSfVvrGTFsLelWb6cakxRNSxcdjfLa6tjAXQScOUkT5VyvQ02nQOi5/IxRDwAJuP96n7G
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199018)(38100700002)(122000001)(38070700005)(33656002)(41300700001)(86362001)(5660300002)(66946007)(64756008)(2906002)(66476007)(55016003)(8936002)(52536014)(66446008)(66556008)(4326008)(8676002)(4744005)(54906003)(76116006)(186003)(26005)(6506007)(9686003)(71200400001)(110136005)(316002)(478600001)(107886003)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4OMzpG7nTk8LJqj85krqh1azNSEReYAJTLjSudTJcam71d4VpMSDx+n2+vpa?=
 =?us-ascii?Q?BjsopY/djuph50MkUy68AebDO5Ed9lWKz9bVdx2reKOXLbuQ9gUUszlSQGM9?=
 =?us-ascii?Q?SzleqRQri0so/unvrgNfOS80nAqn0cscIYfGQ9D9HYno0thgjVBBmBKUXLpz?=
 =?us-ascii?Q?di+CPC+yM6Sa7qLes7Glw0StbPLwTWmbeVX8CTvvWF5y6a6ajOtt+wyrsfQV?=
 =?us-ascii?Q?Nb2Q3ikTGU2BP0Tc8nlI6w0RnYA8ROVick9cKIjAcw0d2wXJ5IsZtZDcdusR?=
 =?us-ascii?Q?jm3jFK3CLTAV9wr9ggGbZc5Elbp4woUTH79VLTKU1xBV67Jjrn/kaapd3xR3?=
 =?us-ascii?Q?FcyjFZE7rjAwFOylRLuOAh7NxZLbja8cfzZVtNDCTagcZc7gTba8AJK+anXe?=
 =?us-ascii?Q?HToOQrr3/grQNDveW51yVZEYPpdSqCWVCXzZqp01wNFcVFfRUvKH8tHG1lDP?=
 =?us-ascii?Q?EJIp2KEgHNIpRLxp3oPUxbFoKZd07JSvXQK3hRk965rcphvVlMCp96nvfB8n?=
 =?us-ascii?Q?HVFUa3GUOucnqb8XUW10PVxNIft/Gdlu1hxUAVVp3EKRmo+b3EmOih5hsYOZ?=
 =?us-ascii?Q?cHo4CoOaba1vjj5hvsNMRQq7jrb3TQXjPPkSaQUNSelyIQDfZ5W8I7qGgT+6?=
 =?us-ascii?Q?lIsi4eLN8gwblvg1BScvLa+qE1yRLc4Kqy56x0oR75AQHI32zF8zCSjCTLaA?=
 =?us-ascii?Q?6ErrmqGNqXP2I8Z5yI4FP8wJE+ZNVrm+QWhdo/RtFYHXnHzqI4gawcl4hktY?=
 =?us-ascii?Q?cDbm2hYYGr3t+BghR9lB84Jea5qXoBQKUAzD+yqcvysggufPud2hepiF0sc+?=
 =?us-ascii?Q?DYWfBqDvAhCyZWFILwFaO7YlGIlHd3n068zFlN/22a3Bv3slVt9ApZrIS4OD?=
 =?us-ascii?Q?jZfkj2+fGfsQGbFJJPMUVqtTNN2DtUJG9Gjel2Q9K9m5140mhM9AIxXFyY4L?=
 =?us-ascii?Q?qaS5sh5cxziLBFC5CnBngqpCzkKpvCLnN5fmEonwQTV02DfJKdLWo/fEraDh?=
 =?us-ascii?Q?n3GvoBuKPwwqns8NYJ4VrvZCb7aEq0zsW/O+MtA4dnfXaslBH1uE+sjx0g4y?=
 =?us-ascii?Q?iJc6qvBQJ2Or6IzhFJ0wEnqKDDbVbD8NilU+HM59EDSSfWjMYbJcevye4gPt?=
 =?us-ascii?Q?Q7LCkaZ4/oPt2PRr2WdWB6KMgHU65leBF3k8aCARHmQTLZv00NfvJhEQc1ae?=
 =?us-ascii?Q?fmHr1EPxIQkL8jWm7eSf4zKuoVcvM4WK7895ENKRFsetSd0m9fzeqGQQ3Fpe?=
 =?us-ascii?Q?yn2wotxxwrwJwdrFkz9u/Jmslia3YMSMBPjaUOeGzrAB+xNgtDkiXhdleLvc?=
 =?us-ascii?Q?8XNalBRdd8yFVu4Y+H4p6dhHnQOV6Y4PBzC07Xi2BFDNzsm6xWc0xvrJq6DR?=
 =?us-ascii?Q?SeWlrtEg2ETytC2Whn2zmmm8g3z57HqQn5dB8VVufdBwMcIbVo/vcBq14PRt?=
 =?us-ascii?Q?CoyaABj2xeSHTiD7uiSZ/PPAql1dsl43dW70qqOEwzQLmMpCyDojJ7X//JNE?=
 =?us-ascii?Q?EqMLRZpUFtgHouB94nNazGucw2aTITI2daAuP2qxAMRbQF7kpJyXrzndHMEs?=
 =?us-ascii?Q?MFbrcorIgMFByf6AbEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3e55b8-7dd3-4d1a-6642-08db1b304c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 15:10:45.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /glOzqwJ2iqS41NMgMqzibYiWr7IthUswFxN0Y0C/UuiMDNGPYvs6IajikUUWaTDFHxB2KD31yU92zljvf6LBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
Subject: [virtio-dev] RE: [PATCH v5 0/6] Split transport specific files



> From: Parav Pandit <parav@nvidia.com>
> Sent: Friday, February 24, 2023 5:22 PM
>=20
> Problem statement:
> Currently several tens of pages worth of transport specification is situa=
ted in
> single file. Many parts of the specification are already maintained in se=
parate
> files.
>=20
> Such separate files enables better maintenance of the specification overa=
ll.
>=20
> Solution:
> Follow the approach similar to rest of the spec, and keep transport speci=
fic spec
> in their individual files.
>=20
> This series is for fixing issue [1].
>=20
> [1] Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
>=20
> Please review.
>=20
> Patch summary:
> patch 1 moves pci transport to its own file patch 2 moves mmio transport =
to its
> own file patch 3 moves channel io transport to its own file patch 4 to 6 =
fixes
> spelling errors existed in the spec which are discovered during splitting=
 the files
>=20
Other patches on top of this needs it.

Please create a voting ballot for this series.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

