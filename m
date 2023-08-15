Return-Path: <virtio-dev-return-13537-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFEAC001B0
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 06:17:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 45522613CD
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 06:17:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BFBD986427
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 06:17:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2FAD7984035; Tue, 15 Aug 2023 06:17:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D39F98633F;
	Tue, 15 Aug 2023 06:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIJHEbV+WfK6SVdnaXppaoiIByYsFuUeYNAiL/cwKUwUJgsfOUpQtGoRjwnQ4quAYCa1+7ylVvteU3HpUDuNe32ov3bB4n7KppNlbh7rV1Bei9iizqfbl8ZiPIfUlGNV4+5s8YBWQzXvsiZ8KKZ7cZTBKthh+RBcRZgX1lXb8CtPsQor5vlGKFyCUPNueiK8U0kRACJ4UYk1L0GWP3+pjuvDdqKY+q4s1XfTpoHFBZVd5BJB7r13mh0oM0LggzKXcrNbhyFXF/RjgNZUVYGnMkWm67x8TdKPnloYiiyiBAfuphhn5jNYhtEwdTl8E6glWfcmI/RZW6BX+1v0bLBtww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=499nJ61O1AG6ZC3FT2Nfh6fe569hwGZhRPaLFj2sjg0=;
 b=nxTY7Ra9cKKBvBAWPnunw9NRdBCzv/R8JUzEcM2SK/D9nf0N9x36MyzOMQhLnRycmajvAObMQjTgqyXtCh3FEnt6GCaZrEEdeg+Drcc+DcD6A7+6QaQHMoz5rmDHrB0Po7GJww/AwofourHMJxTYiEHPOVe9I+Z0B0k+KI9mWnUVymLNlDTEdnaYPKLhqNi1K7pfBU06et+dicXcY9Mcq9qRbIDdrmMwCgKPfpfEiqAltipWW4Sgkl9eKqfptGzkezbGKoisHi0scJXxy8XIZB/fWauBkBBWiAbO0yJHJdtLRtYwOTcjHitU7E4tPq3RFPZZqW79V6MxYspbQONysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: [virtio-dev] [PATCH v14 RESENT] virtio-net: support device
 stats
Thread-Index: AQHZw4OXY4sLFyf1KUOg+p/lWPzH1a/eZgaAgAxnGoCAAA3Q4IAAGTWAgAAEDMA=
Date: Tue, 15 Aug 2023 06:17:14 +0000
Message-ID:
 <PH0PR12MB5481A89E24577A0FBC1F8D35DC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230731074945.108883-1-xuanzhuo@linux.alibaba.com>
 <1691388913.8316696-2-xuanzhuo@linux.alibaba.com>
 <1692070761.567899-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54815E430B977F2969C9FAEADC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1692079141.2231495-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692079141.2231495-4-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7697:EE_
x-ms-office365-filtering-correlation-id: f604feb3-903d-4c22-5fd3-08db9d574498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 shJVW6xUJvOpiG7fAsdBAATDS/Lwsolqkxzj/Ffuw1wM2sy3Thg9jP2Pl7j8hyS8LeMyb9xyaAC9Ov5cIyCjGVITpS6HsbgtCHJZg/hD99tc4B/TKQVuc3Rn5ZbohMZw7rf5UX0Si6LkDmnCzaOWMNR1q6JFwG67R5YifFamEt8Sw5Afl7SQA0EwCZS8zhdD66JvliLMUonSzHwFvMfL+5Nz858LVHhXQdgWIEKLPkaMUCbfx856rv7wDGE22YPNu4durhT8yUtUUw96vgxszm6S9G+FnWgsuC+kHIH5VWN46Nr+afSYPmYVOPsK1IQqK0hj0+9ox/KeAmNL2jRzSoNk79KI+nh9tTpW8ga+sTd8pExJsKY/LgdSHALNN7RBKJKzXLF2yG3A4zFVyozCGBfGu+cQaF9n9oDhAImyxltU4/3c1WMPnhRiRkwKrOusoM/SAtyl6z9A9QqYCrXgIFfrfkmIo00vRMXixggdfLUMEbzwl+e9xWOYHi5i4n4BJ/XxKXSliEsiO3SAaigtbjyaiPxVanPbupcl63OrhKR7L8MQvNhvyazg0I4RD75Q2q46+BKau9gtDxUWI2LpR/sBaHWCsjphl8akRpz8IAU/d+s/swjvKgL2YF+M4Yd2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(33656002)(83380400001)(86362001)(55016003)(41300700001)(478600001)(38070700005)(66946007)(66476007)(54906003)(76116006)(64756008)(6916009)(66556008)(122000001)(9686003)(316002)(8676002)(66446008)(52536014)(5660300002)(4326008)(8936002)(38100700002)(7696005)(2906002)(6506007)(4744005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MI2ImcVC2DTzI8tQw+VFiXYqY+5F3mmtcHd5trjFMv8IAocMdGswRp5WqUDu?=
 =?us-ascii?Q?9C8IW9tYqkLFgA0fSCXRMK8jwWiiYgKaEN7F7C5qtYBXA9610mEk2010u25s?=
 =?us-ascii?Q?/9xBIELit9rlKxSnNGDETNJn+oeP2Vls02E20KVnDkO9gen0NaXMRD3kX6/t?=
 =?us-ascii?Q?RORnZat1uY3rVfik3kd/C3YR/hif4CqW26vAJg/u0EDMbSX8WkicLoCQWhjq?=
 =?us-ascii?Q?t4jShIv+ChIc7zdW6HKIrCnCDz7lBvZlEyiNZ8EyPP9l4TEt9JLNQBcU6d8f?=
 =?us-ascii?Q?Fh3xRwQsGKO+nluW74hSl2e7/QTB9QjfhxplBGfZw18r3NF+rDYWOxjXJ+IQ?=
 =?us-ascii?Q?CYlYBwrayxzRziSak5vwS1NN0swyVxD38xqwjtv2o0MJY0P+1Oqz4Oy09yWN?=
 =?us-ascii?Q?qILwnwsuDja42vGBUfyD9wZ6OZLDXa0ckENU0UFpWiYKMGgxQvPR58VQVLjq?=
 =?us-ascii?Q?i8UBoQ7vIzh06XQslLxHe9r0XxIQAxGNS9w72gDMKjIX8TQXbmsooa03dEcY?=
 =?us-ascii?Q?/pnbyIcbr99zQSa4jmHCdqhK4gVv0A5DvDvfI2YrTzxzAF0TqjEHuaycuf8h?=
 =?us-ascii?Q?31ts57uBX29fAeeniUdnMPfFBCBDVbOqXZ/gjlEDoZXWBinYej5NKirDd0xi?=
 =?us-ascii?Q?RcuVRLCzB0atue1jt8wmkR09UHIYZWkpyLhNAQaGAP1kD5BuqzHqQoeqrVyP?=
 =?us-ascii?Q?nnvmwTeL3u8zjT/QAYkxcSuATFsOPvEOP7anNBO4X6ki6pe31mPPpx9wSZwH?=
 =?us-ascii?Q?KdoVfbXb/4pMtwAwWhJvsGes1f7j9zp0xTQz0xSEyNFcLuKk4JmLe3GKlICB?=
 =?us-ascii?Q?fWpnLZQoQyDO3s2U3TAa6vIGjOJMjve6iwv+Ru85J9WyW9+0U+numGya6NAS?=
 =?us-ascii?Q?PFY+KRo3adHpZYPheKlaYvOdjO0T2DNPMQ9BBDT8Jy/av8Dq8ldhVx1tSA52?=
 =?us-ascii?Q?Qt8bXgSsDJpH4tba8L5n0IszfIATX2/j1Bi5Vc+v34IPpzqTazoWkIC7HkwG?=
 =?us-ascii?Q?nJkyyXIbzCAhfUN2BzgBLcFY/0qsiV/Xv+9M0rZwNviMvTb0kSuR+EPo4Px7?=
 =?us-ascii?Q?AngQc4cEyp1HI7nWVlaeWFnrFj7cAXHw5aJVefw+mK3f0gsYWAQ6Kruem1hF?=
 =?us-ascii?Q?3UO+KjCcPAXrT9DrzI3yNg/79C58wd0uT+cwRb8YMHIFCkmFA9H4g2TYO269?=
 =?us-ascii?Q?2qx3KloHVbILasMEr8iDwGdJXq9vUXdeuxxIDCEGqOYjqzHi+rUCY4+yMAw7?=
 =?us-ascii?Q?huhvbPh/3Txu8y4wSFMs/sOj8XuWKEHIUlARKXqNV56kHXrKEfw+4dEYcCuY?=
 =?us-ascii?Q?eroWcSpcILqLqSeSyJobT+NFbrmTa5XyF1WGjXMXB7Dipd9gp5uGoR1Js7Ju?=
 =?us-ascii?Q?1RoLl9id6ntFXzZ097gA+OZUKOvj1WbOH4PtBF4qDx6KfQh7aJXzKoLSzFfV?=
 =?us-ascii?Q?ZkTFTSpvXy3VnRK84Wv9WvsW4T0V6mVf0Lq6G/6au73DJ/ESxOaLlDgdRlzy?=
 =?us-ascii?Q?0mQFH6x+4X2lAyxcMbnfMg+6W0N5AYFxgF3x6id88HaKMF2eCWGRA6QHiKnD?=
 =?us-ascii?Q?RCUOpt4GKDNsypdmwfrr3d7FsrSICjiMObDyOMk/Pi8z46Upy3UEXKdORiBK?=
 =?us-ascii?Q?sLHnKz6ZraD0u8hpoPezprc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f604feb3-903d-4c22-5fd3-08db9d574498
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 06:17:14.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tS4+jpUsjDFJDOftSAHFdQeIdlhdRR+6W/WTAcC/1eyBNxB3NnBmJktwSxF16lJC81AyQfvSk+8COzrHuAcnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
Subject: RE: RE: [virtio-dev] [PATCH v14 RESENT] virtio-net: support device
 stats


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 15, 2023 11:29 AM


> This version already has the bitmap. I forgot to change the commit log.

Please move to access via DMA interface discussed under subject "virtio-net=
: support access and control the member devices".
For virtio net this dma interface of cvq already exists. Please relocate it=
 to a cvq command.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

