Return-Path: <virtio-dev-return-13611-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB5FC71153
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 10:26:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 91B2919093C
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 10:26:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B355986478
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 10:26:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6B5C0983E4F; Mon,  4 Sep 2023 10:26:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BAB69863B7;
	Mon,  4 Sep 2023 10:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAIkjHjbSXb1sMEniJfjRXq0DPjcRkiC/RCYgqzWSgStYpQkrcBtpYCEpmvJMy13dmAhN5lJvUe6ephgdnHhfTZ9YgwOaH/RDrba1jcJ7fEVWEVCnzwHdW46VwJR8eUEBEnPYPvr44+7W0++twSmXzcluAYiNhAIRCD+2bUr+E7Y2ZWFSQJM2PaWK9St4h5CpNR+BCC8K7/qKgS7N+ANWys5x/N6yhOnyF/01qKnjpirbsHqsuGE3X6y7caCFGuK5R84DCl4+Blhhosc0sPkaqFRBbBVaSutVy6nuSgImGRe/aJ7ph7cuXyu4XUk2dOpyd0l+nKIs7pRaFurPIKyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxtYh/Dtbvn2pHZ4gOK/xBIsqwcOp9GCqLCuWfTTn0s=;
 b=clAf9xu0fwmAoQvFxXP32gC5+neq/iiwmj5GckfsCDLbokoKOxzXrxf6Iw6HqOMvXLi7am4Bv/VMhRZM02cUghPv7jLTZpRn+mFGf38A+PDzF3peFQXjqWsATR7iTTeUGIqSlII1C91lUeglFyZZSHH9J55/jBxGkCF0Z+9nzE5mnyGvTqpxnwAgM4STcqzWa03p7/rYYgWe5oWMnwDc0FdNtcu4GHtmmMSniuMGIa6PcPvp+BMp/AE+NHlirbJVwp/2R0CwWYjHfGkRoN9EYtszn+47j7uN6B0iAaYkU8RXD6Uc2u8FDIr00kTnMkq0DESyZ1v8Vp+GDITY+UJuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: RE: RE: RE: [PATCH v16] virtio-net: support device stats
Thread-Index:
 AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaAgARYMQCAAASwYIAAA0cAgAABWeCAAAy/gIAAGFyQ
Date: Mon, 4 Sep 2023 10:26:30 +0000
Message-ID:
 <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7489:EE_
x-ms-office365-filtering-correlation-id: 5805908b-c806-4370-715a-08dbad31675b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NBxTh8SQbNYcBPzpaqzU/qB6NKiRfT02xOpnM9hYt33s3feP2rLhmbfbcEt5VnS+Qwl61AWvHr0JSQF58GwzVppSjJYc2HqHKV9tVT3G20lDFtsgJxtYKz4QkhtEUxjwuUB0svkQ4kCPvH2Xn/FtnoHJMFijbOx64wpgv+uhXu8iG0H4RsOOTRpFwZWMntKhf28IhnToljNbepkl4eJdXOaBPgtfA+RwV+nsnhvz/JN6qqSPG9tQaHplyMf/B9chGim5IsekH2x0yURu6FkAkpydUNaMnsw5u2+/ukVSXAFydfxHQ7ijRajSAuX9rUr6ZbgmNR47krcKqzpq0lu8nE8ry3K7YOsJA/aepQXxHTfRDFd888i3QF9WkWMsmc31/+z7T4Z1Qy/SlA/of88C+2Bk/FHZfAn5Zw2S2zSXnYFJdw4xrEt/eh57yNkjcHoOTNlzHa/5NsVtyepAlECvPhtl3CC4BGQAePVd8VP9geD6GimNlCi2mfB/yB/0YOFf/IJVOwHV6nsYUQ+zNJcn6hKxko52jjJAb6aM1D1Nch8jIpKRGgcUUvba7dCfAJOHZ1JBAS+LAPoWoX7qmpTKCiSEbEOL4MG/dFntX/9GoTyoJ5UCZFGnqQPPAklXiHWP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39850400004)(1800799009)(186009)(451199024)(5660300002)(55016003)(52536014)(41300700001)(26005)(2906002)(4744005)(122000001)(86362001)(38100700002)(38070700005)(33656002)(4326008)(8936002)(8676002)(83380400001)(55236004)(6506007)(7696005)(9686003)(478600001)(6916009)(316002)(66946007)(71200400001)(76116006)(66476007)(54906003)(64756008)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WLJJNa+YVf9F40c+ytBqFwWSJH+2ymQJ4P6aidmYZp/Wxec+kkNTEZawLXAv?=
 =?us-ascii?Q?HMA7tHrW/PALdbGIIiansI8JWbFM6MqhBxTIrzO+PVXc24q0o6BRsIZMmP+K?=
 =?us-ascii?Q?nwJGLI8Vt9j1a5bUz/6USc+Mf1T9hGDWqokHB+VRsqW3itkn10du91Q8yBB7?=
 =?us-ascii?Q?agJ4AA4lLRlD0I7qBCXaL2pQvs5qLT6mmPYmWwwopG8+Zv74VCl7mord5eFB?=
 =?us-ascii?Q?Kez35ZyCFQ+wRx98FKOhx4hYryctayrhknxVZkI/VmljI/2Y69JIvUNhDDN7?=
 =?us-ascii?Q?6JGPTHNslr/WfG8f2EYmwmw+z5qRJvsG1oihJNuRan3OC+/Kd9Mmizbt45wu?=
 =?us-ascii?Q?0K4oW93SWQMlhcTHVw+Auwj4jZs/QyZHFINCHLoCQGGZ05mTeXbGgGDuA+h6?=
 =?us-ascii?Q?ZoJEPdD9K2U6BtYbXg5CphDQ3s7C3/8jruILb7JmLwB2lS+j8G/q7HPEEbTG?=
 =?us-ascii?Q?wO6CODNIqvmnCq3REetk+EafX5oAppAEVzXi7vUZ6zIIDWA4yafOtUqpOk5e?=
 =?us-ascii?Q?XVm5Kv1KYjsftMnRco/y1aBNpfvVzxEn1JT6HUHfyZuqRzZRBzSpOvx7106+?=
 =?us-ascii?Q?ntZLnlk4ALWb6nuzaalFVXE1COslGE6cjhB0W30MjjawlmizFb+tFO121244?=
 =?us-ascii?Q?NCry9poFt+R664uKe5F4PtboiPVb6GsFFFJ4rYNFjG+1XfxDfN2r+JgxveFO?=
 =?us-ascii?Q?fRJY5bng2asPqxdoAjcyUGBA/pUiNtZbni6lIoFXKpjBoXK6wXpXXhLJgUlI?=
 =?us-ascii?Q?9rKuGCEMeRdNcBF/SPHuLV7f22xrl19jknLnog9ah278gB43TWUZpTqacKoz?=
 =?us-ascii?Q?pVf0BpYBg9VJJhjxsshAuT4WD9tUqflP5/FDrhB9dDc99Ds2e8tlbw70NEiK?=
 =?us-ascii?Q?3j4WqfQ/J4uBV3yJl6ZLJBYLRiKfpAV9j1VNmBvFmw3T5GY9kWWRtPbgnXvz?=
 =?us-ascii?Q?wNyp84jAi9tU4GGod2Zwnf6C/vtXrx0OzCLb4mnaWRBK0jhax6HnNfhosKRH?=
 =?us-ascii?Q?uHy29YNT+Xd2gwAT8WSH5XB7+5pIs5AL+6udFSDVK/xO2P/pI4oty0BnVG5/?=
 =?us-ascii?Q?YZF55CqGfac4Tcno8FiFSvxW82ipqvg6EPTvIcFSKzBLCD5w/A5P/uQGiFBa?=
 =?us-ascii?Q?+6Uxr7bCLNBCQaCaLJgPmWKH4Kfu1HBa2F+QKEJJV9afmSssZTjfFXc5PcCb?=
 =?us-ascii?Q?sJAoMsIV/I+rawc+weRtWzWfMx5FN6TcRNL7QpDFTxY6xCVZvg5+LIsLop8V?=
 =?us-ascii?Q?ixZ1O1sPQcCQnX++qGCH7ptqUS2tzs/kygDC6lGMH7x9BfmgrQDls1YvUYgo?=
 =?us-ascii?Q?9GIdWaq01+ZFqvB3aynPK328WconEjr5+8AXOGkjUWosxK81Pl5eJb+uKYoS?=
 =?us-ascii?Q?vZeR60WsG3cMST9jSnUxaTAaEuVtbaWuCNUMYEkFZJpKz77u4RBSkcx2BuyM?=
 =?us-ascii?Q?hiL3kZD7SCkTlKRE8+6Hc7bE3QLH1+zKjnD83s9H/Set8v1p++Be5mX3Z+WX?=
 =?us-ascii?Q?2jGKZXopXyGmHOagvOyxA8MOpf7Qy3+BaxjHTbfm/jqA6yvwEfZc7FcGy2QR?=
 =?us-ascii?Q?BeO1ZJJkG0tZUQGkz9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5805908b-c806-4370-715a-08dbad31675b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 10:26:30.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwA1TPhXJKple6OZzLRhao1kJYwmu4tUSWhbiXXUFnSbGom5CCso4oIYDFK8FDzBWMqD/1wH46MWPTNDOIfzZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
Subject: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support device stats


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, September 4, 2023 2:23 PM


> > "The device MUST NOT pass received packets that exceed mtu (plus low
> > level ethernet header length) size with gso_type NONE or ECN after
> VIRTIO_NET_F_MTU has been successfully negotiated."
>=20
> NO.
>=20
> If the mtu is 1500, we can pass 64k packets to the driver with gso_type (=
not
> NONE).

Any supporting citation to spec for above comment?

Each packet must be 1500 for the mtu normative above.
gso_size to <=3D mtu (ingoring the hdr math for simplicity for now).
whole GSO completion can be for 64K to be reported in used_elem.len.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

